const express = require('express')
const app = express()
const port = 3002

const { PrometheusExporter } = require('@opentelemetry/exporter-prometheus');
const { MeterProvider }  = require('@opentelemetry/sdk-metrics-base');

// Add your port and startServer to the Prometheus options
const options = {port: 9090, startServer: true};
const exporter = new PrometheusExporter(options);

// Register the exporter
const meter = new MeterProvider({
  exporter,
  interval: 1000,
}).getMeter('demo-prometheus');

// Now, start recording data
const counter = meter.createCounter('count_movies', {
  description: 'Count movies api'
});


app.get('/movies', async function (req, res) {

  counter.add(1, { service_name: "service_3" });
  counter.add(1, { service_name: "service_3", status: "success", path: "/movies" });
  counter.add(1, { service_name: "service_3", status: "failure", path: "/movies" });
  counter.add(1, { service_name: "service_3", status: "data not found", path: "/movies" });

  res.type('json')
  var delay = Math.floor( ( Math.random() * 2000 ) + 100);

  setTimeout((() => {
    res.send(({movies: [
      { name: 'Jaws', genre: 'Thriller'}, 
      { name: 'Annie', genre: 'Family'},
      { name: 'Jurassic Park', genre: 'Action'},
    ]}))
  }), delay)

})

app.listen( port, () => { console.log(`Listening at http://localhost:${port}`)})