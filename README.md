# Simulación Dinámica del Sistema Solar (N-Cuerpos)

Simulación numérica del problema gravitatorio de $N$ cuerpos aplicada a los planetas del sistema solar, evaluando trayectorias, conservación de energía y momento angular.

## Estructura y Metodología
- **Cálculo numérico (`Fortran 90`):** Integración de las ecuaciones del movimiento gravitatorio newtoniano mediante algoritmo de Verlet/Runge-Kutta.
- **Análisis y Visualización (`Python`):** Procesamiento de trayectorias, análisis orbital y generación de animaciones cinemáticas con Matplotlib.
- **Validación física:** Verificación de conservación de la energía mecánica total ($E$) y momento angular ($\mathbf{L}$), así como comprobación de las leyes de Kepler a partir de los periodos orbitales.

## Requisitos y Ejecución

### 1. Núcleo numérico (Fortran)
Requiere `gfortran`:
\`\`\`bash
gfortran -O3 sistema_solar.f90 -o sistema_solar
./sistema_solar
\`\`\`

### 2. Animación y análisis (Python)
Requiere `numpy` y `matplotlib`:
\`\`\`bash
python Dinamica_Sistema_Solar.py
python Animacion.py
\`\`\`

## Archivos generados
- `energia_sistema.txt`: Evolución temporal de la energía mecánica total.
- `momentos_planetas.txt`: Evolución del momento angular por cuerpo.
- `periodos_planetas.txt`: Periodos orbitales calculados numéricamente.