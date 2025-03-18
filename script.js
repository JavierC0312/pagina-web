document.addEventListener('DOMContentLoaded', function () {
    const ctx = document.getElementById('gaugeChart').getContext('2d');
    const needle = document.getElementById('needle');
    const gaugeValue = 70; // Valor inicial del medidor
  
    const gaugeChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: ['Bajo', 'Medio', 'Alto'],
        datasets: [{
          data: [33.33, 33.33, 33.34], // Porciones fijas
          backgroundColor: ['#4CAF50', '#FFEB3B', '#F44336'],
          borderWidth: 0
        }]
      },
      options: {
        circumference: 180,
        rotation: -90,
        cutout: '70%',
        plugins: {
          legend: {
            display: true,
            position: 'bottom'
          },
          tooltip: {
            enabled: false
          }
        }
      }
    });
  
    // Función para actualizar el valor del medidor y posicionar la aguja
    function actualizarMedidor(valor) {
      // Calcular el ángulo para la aguja (0-180 grados)
      const angle = (valor / 100) * 180 - 90;
      needle.style.transform = `rotate(${angle}deg)`;
    }
  
    // Actualizar el medidor a un valor inicial (por ejemplo, 70)
    actualizarMedidor(gaugeValue);
  });
  