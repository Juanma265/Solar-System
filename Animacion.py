import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

ARCHIVO = 'sistema_solar.txt'
SALTAR_STEPS = 20  # Dibuja 1 de cada 10 filas para acelerar la animación
INTERVALO = 30    # Milisegundos entre fotogramas


data = np.loadtxt(ARCHIVO)


nombres = ["Sol", "Mercurio", "Venus", "Tierra", "Marte", "Júpiter", "Saturno", "Urano", "Neptuno"]
colores = ["#FFCC00", "#999999", "#E3BB76", "#2E7AD1", "#E27B58", "#D39C7E", "#C5AB6E", "#B5E1E1", "#3E54E8"]
tamanos = [10, 3, 5, 5, 4, 9, 8, 6, 6]

fig, ax = plt.subplots(figsize=(9, 9))
ax.set_facecolor('#050505')
ax.set_aspect('equal')
limit = 32  
ax.set_xlim(-limit, limit)
ax.set_ylim(-limit, limit)


puntos = [ax.plot([], [], 'o', color=colores[i], markersize=tamanos[i], zorder=3)[0] for i in range(9)]
estelas = [ax.plot([], [], '-', color=colores[i], alpha=0.3, linewidth=1, zorder=2)[0] for i in range(9)]


def update(frame):
    actualizaciones = []
    for i in range(9):
        idx_x = 2 * i
        idx_y = 2 * i + 1
        
        x_actual = data[frame, idx_x]
        y_actual = data[frame, idx_y]
        puntos[i].set_data([x_actual], [y_actual])
        
        inicio_estela = max(0, frame-100000)
        x_hist = data[inicio_estela:frame, idx_x]
        y_hist = data[inicio_estela:frame, idx_y]
        estelas[i].set_data(x_hist, y_hist)
        
        actualizaciones.extend([puntos[i], estelas[i]])
    return actualizaciones


ani = FuncAnimation(fig, update, 
                    frames=range(0, len(data), SALTAR_STEPS), 
                    interval=INTERVALO, 
                    blit=True)

plt.title("Evolución del Sistema Solar", color='white')
plt.grid(color='#222222', linestyle='--')
plt.show()
