<main>
    <section class="Monitoreo">
        <h2>Estado de los Sensores</h2>
        <table class="sensor-table">
            <thead>
                <tr>
                    <th><i class="fas fa-tint"></i>Humedad del Suelo</th>
                    <th><i class="fas fa-thermometer-half"></i>Temperatura del Suelo</th>
                    <th><i class="fas fa-flask"></i>pH del Suelo</th>
                    <th><i class="fas fa-sun"></i>Luminosidad</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><canvas id="chartHumedad"></canvas></td>
                    <td><div id="apexTemperatura"></div></td>
                    <td><canvas id="chartPH"></canvas></td>
                    <td><div id="apexLuz"></div></td>
                </tr>
            </tbody>
        </table>
    </section>

    <div id="secciones-container">
        <section class="Monitoreo">
            <h2>Otros Parámetros</h2>
            <table class="sensor-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-temperature-high"></i>Temperatura Ambiente</th>
                        <th><i class="fas fa-cloud-sun-rain"></i>Humedad Relativa</th>
                        <th><i class="fas fa-tint"></i>Nivel de Agua</th>
                        <th><i class="fas fa-cloud"></i>CO2 en el Ambiente</th>
                        </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><canvas id="chartTempAmbiente"></canvas></td>
                        <td><div id="apexHumedadRelativa"></div></td>
                        <td><canvas id="chartAgua"></canvas></td>
                        <td><div id="apexCO2"></div></td>
                    </tr>
                </tbody>
            </table>
        </section>
    </div>
    <button onclick="agregarSeccion()">Agregar nueva sección</button>
    <script>
    // Funciones para crear los gráficos
        function getColor(value) {
            return value < 30 ? 'red' : value < 60 ? 'yellow' : 'green';
        }

        function createChartJSGauge(id, value) {
            new Chart(document.getElementById(id).getContext('2d'), {
                type: 'doughnut',
                data: {
                    datasets: [{
                        data: [value, 100 - value],
                        backgroundColor: [getColor(value), '#ddd'],
                        borderWidth: 0
                    }]
                },
                options: {
                    circumference: 180,
                    rotation: 270,
                    cutout: '75%',
                    plugins: { legend: { display: false } }
                }
            });
        }
        function createApexGauge(id, value) {
            new ApexCharts(document.querySelector(`#${id}`), {
                chart: { type: 'radialBar' },
                series: [value],
                labels: [''],
                colors: [getColor(value)],
                plotOptions: {
                    radialBar: { hollow: { size: '60%' } }
                }
            }).render();
        }
        function agregarSeccion() {
            const container = document.getElementById("secciones-container");
            const idSuffix = Date.now();
            const nuevaSeccion = document.createElement("section");
            nuevaSeccion.className = "dashboard";
            nuevaSeccion.innerHTML = `
                <section class="Monitoreo">
                    <h2>Otros Parámetros</h2>
                    <table class="sensor-table">
                        <thead>
                            <tr>
                                <th>Temperatura Ambiente</th>
                                <th>Humedad Relativa</th>
                                <th>Nivel de Agua</th>
                                <th>CO2 en el Ambiente</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><canvas id="chartTempAmbiente${idSuffix}"></canvas></td>
                                <td><div id="apexHumedadRelativa${idSuffix}"></div></td>
                                <td><canvas id="chartAgua${idSuffix}"></canvas></td>
                                <td><div id="apexCO2${idSuffix}"></div></td>
                            </tr>
                        </tbody>
                    </table>
                </section>
            `;
            container.appendChild(nuevaSeccion);
            createChartJSGauge(`chartTempAmbiente${idSuffix}`, Math.floor(Math.random() * 100));
            createApexGauge(`apexHumedadRelativa${idSuffix}`, Math.floor(Math.random() * 100));
            createChartJSGauge(`chartAgua${idSuffix}`, Math.floor(Math.random() * 100));
            createApexGauge(`apexCO2${idSuffix}`, Math.floor(Math.random() * 100));
        }

        // Crear los gráficos iniciales
        createChartJSGauge('chartHumedad', Math.floor(Math.random() * 100));
        createApexGauge('apexTemperatura', Math.floor(Math.random() * 40));
        createChartJSGauge('chartPH', Math.floor(Math.random() * 14));
        createApexGauge('apexLuz', Math.floor(Math.random() * 100));
        createChartJSGauge('chartAgua', Math.floor(Math.random() * 100));
        createApexGauge('apexCO2', Math.floor(Math.random() * 100));
        createChartJSGauge('chartTempAmbiente', Math.floor(Math.random() * 40));
        createApexGauge('apexHumedadRelativa', Math.floor(Math.random() * 100));
    </script>
<main>