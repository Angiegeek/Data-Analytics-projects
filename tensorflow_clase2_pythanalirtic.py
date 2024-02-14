#Angie Vargas 
#Universidad Cenfotec
#Machine learning usando tensor flow, matplotlib y numpy
#Librerías
import tensorflow as tf         #Redes neuronales
import numpy as np              #Manejo de Arrays
import matplotlib.pyplot as plt #Graficación

print("")
print("Prueba de Redes Neuronales")
print ("")

#Carga del muestreo
#ENTRADA
dias=np.array([1,10,15,20,30,60],dtype=float)

#SALIDA
multa=np.array([10000,100000,150000,200000,300000,600000],dtype=float)
#Definición de red neuronal
capa=tf.keras.layers.Dense(units=1, input_shape=[1])
modelo=tf.keras.Sequential([capa])

#Compilación del modelo de red neuronal
modelo.compile (
    optimizer=tf.keras.optimizers.Adam(0.1),
    loss='mean_squared_error'
)
print ("")
print ("Comenzando entrenamiento")
#Carga del modelo de red neuronal
historial=modelo.fit(dias, multa, epochs=750000, verbose=False)
print ("Modelo Entrenado")
#Graficación de los errores y aproximación de solución
plt.xlabel("#EPOCA")
plt.ylabel("Magnitud de pérdida")
plt.plot(historial.history["loss"])
plt.show()

# Impresión de peso de conexión y sesgo
print("")
print ("Variables internas del modelo")
print (capa.get_weights())
print("")

#Machine Learning
print ("Hagamos Cálculo")
atraso=float(input("Digite los días de atraso: "))
resultado=modelo.predict([atraso])
print ("Multa: ",resultado)

