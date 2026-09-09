import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt('sistema_solar.txt')


nombres = ["Sol", "Mercurio", "Venus", "Tierra", "Marte", "Júpiter", "Saturno", "Urano", "Neptuno"]
colores = ["yellow", "gray", "orange", "blue", "red", "brown", "khaki", "cyan", "royalblue"]


plt.figure(figsize=(10, 10))
plt.style.use('dark_background') 


for i in range(9):
    
    idx_x = 2 * i
    idx_y = 2 * i + 1
    
    #Lectura de todos los datos
    x = data[:, idx_x] 
    y = data[:, idx_y]
    
    # Dibujar la línea de la órbita
    plt.plot(x, y, label=nombres[i], color=colores[i], linewidth=1)
    

plt.grid(color='gray', linestyle='--', alpha=0.3)
plt.legend(loc='upper right', fontsize='x-small', ncol=2)
plt.title("Simulación de la Dinámica del Sistema Solar ")
plt.xlabel("Distancia Reescalada (UA) ")
plt.ylabel("Distancia Reescalada (UA)")

plt.show()