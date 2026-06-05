const express = require("express");
const cors = require("cors");
const client = require("prom-client");

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors());
app.use(express.json());

/**
 * Prometheus metrics setup
 */
const register = new client.Registry();

client.collectDefaultMetrics({
  register,
  prefix: "eks_observability_",
});

const httpRequestCounter = new client.Counter({
  name: "eks_observability_http_requests_total",
  help: "Total number of HTTP requests",
  labelNames: ["method", "route", "status_code"],
});

const httpRequestDuration = new client.Histogram({
  name: "eks_observability_http_request_duration_seconds",
  help: "HTTP request duration in seconds",
  labelNames: ["method", "route", "status_code"],
  buckets: [0.05, 0.1, 0.3, 0.5, 1, 2, 5],
});

register.registerMetric(httpRequestCounter);
register.registerMetric(httpRequestDuration);

/**
 * Metrics middleware
 */
app.use((req, res, next) => {
  const start = process.hrtime();

  res.on("finish", () => {
    const route = req.route && req.route.path ? req.route.path : req.path;
    const statusCode = res.statusCode.toString();

    httpRequestCounter.inc({
      method: req.method,
      route,
      status_code: statusCode,
    });

    const diff = process.hrtime(start);
    const duration = diff[0] + diff[1] / 1e9;

    httpRequestDuration.observe(
      {
        method: req.method,
        route,
        status_code: statusCode,
      },
      duration
    );
  });

  next();
});

/**
 * Routes
 */
app.get("/", (req, res) => {
  res.status(200).json({
    message: "AWS EKS Terraform Observability Platform API",
    status: "running",
    environment: process.env.NODE_ENV || "development",
    version: "1.0.0",
  });
});

app.get("/health", (req, res) => {
  res.status(200).json({
    status: "healthy",
    uptime: process.uptime(),
    timestamp: new Date().toISOString(),
  });
});

app.get("/metrics", async (req, res) => {
  try {
    res.set("Content-Type", register.contentType);
    res.end(await register.metrics());
  } catch (error) {
    res.status(500).json({
      error: "Could not collect metrics",
    });
  }
});

/**
 * 404 handler
 */
app.use((req, res) => {
  res.status(404).json({
    error: "Route not found",
    path: req.path,
  });
});

/**
 * Start server
 */
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Backend API running on port ${PORT}`);
});