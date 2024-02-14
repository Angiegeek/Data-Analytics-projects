"""PROYECTO DE TENDENCIA Y ANALISIS DE NUMEROS DE LOTERIA
Angie Vargas Matarrita
UNIVERSIDAD CENFOTEC"""
#Funcion para leer el archivo que nos da el Profesor
def leer_datos(archivo):
    datos = []
    with open(r"C:/datos/loteria.csv") as archivo:
        for linea in archivo:
            v=linea.split(',')
            numero=int(v[0])
            mes=int(v[1])
            veces=int(v[2])
            datos.append((numero, mes, veces))
    return datos
#Funcion para realizar los calculos solicitados
def calcular_estadisticas(datos):
    # Inicializar diccionarios para contar la cantidad de veces que aparece cada número y mes
    contador_numeros = {i: 0 for i in range(100)}
    contador_meses = {i: 0 for i in range(1, 13)}

    # Contar ocurrencias de números y meses
    for numero, mes, veces in datos:
        contador_numeros[numero] += veces
        contador_meses[mes] += veces

    # Encontrar el número que más ha salido
    numero_mas_salido = max(contador_numeros, key=contador_numeros.get)

    # Calcular distribución entre números bajos y altos y entre semestres
    total_bajos = sum(contador_numeros[i] for i in range(50))
    total_altos = sum(contador_numeros[i] for i in range(50, 100))
    distribucion_semestres = {
        'enero_junio': sum(contador_meses[i] for i in range(1, 7)),
        'julio_diciembre': sum(contador_meses[i] for i in range(7, 13))
    }

    # Determinar la tendencia entre números bajos y altos en los semestres
    tendencia_semestres = {
        'enero_junio': 'bajos' if total_bajos > total_altos else 'altos',
        'julio_diciembre': 'bajos' if total_bajos < total_altos else 'altos'
    }

    return numero_mas_salido, tendencia_semestres

if __name__ == "__main__":
    nombre_archivo = "loteria.csv"
    datos = leer_datos(nombre_archivo)
    numero_mas_salido, tendencia_semestres = calcular_estadisticas(datos)
    
#Resultados en consola
    print(f"El Número que más ha salido: {numero_mas_salido}")
    print(f"La Tendencia entre números bajos y altos:")
    print(f"  - Enero-Junio: {tendencia_semestres['enero_junio']}")
    print(f"  - Julio-Diciembre: {tendencia_semestres['julio_diciembre']}")


