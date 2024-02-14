#Angie Vargas Matarrita
#Universidad Cenfotec
#Objetivo: Crear un programa para un parque de diversiones que
# # inserte, elimine, actualice y busque atracciones, con opcion final de salir 

class Atraccion:
    def __init__(self, nombre, estaturaMinima=0.0, nivel=1, restricciones=None, estado=True):
        self.nombre = nombre
        self.estaturaMinima = estaturaMinima
        self.nivel = nivel
        self.restricciones = restricciones if restricciones is not None else []
        self.estado = estado

# Función para insertar una atracción en la lista y guardar en el archivo
def insertar(atraccion, lista_atracciones, archivo):
    for atr in lista_atracciones:
        if atr.nombre == atraccion.nombre:
            print("La atracción ya existe.")
            return

    lista_atracciones.append(atraccion)
    guardar_en_archivo(lista_atracciones, archivo)
    print("Atracción insertada correctamente.")

# Función para eliminar una atracción de la lista y guardar en el archivo
def eliminar(nombre, lista_atracciones, archivo):
    for atr in lista_atracciones:
        if atr.nombre == nombre and atr.estado:
            atr.estado = False
            guardar_en_archivo(lista_atracciones, archivo)
            print("Atracción eliminada correctamente.")
            return
        elif atr.nombre == nombre and not atr.estado:
            print("La atracción ya estaba inactiva.")
            return

    print("Atracción no encontrada o ya inactiva.")

# Función para actualizar una atracción en la lista y guardar en el archivo
def actualizar(nombre, estatura, nivel, restricciones, estado, lista_atracciones, archivo):
    for atr in lista_atracciones:
        if atr.nombre == nombre:
            atr.estaturaMinima = estatura
            atr.nivel = nivel
            atr.restricciones = restricciones
            atr.estado = estado
            guardar_en_archivo(lista_atracciones, archivo)
            print("Atracción actualizada correctamente.")
            return

    print("Atracción no encontrada.")

# Función para buscar atracciones activas o inactivas
def buscar(atracciones, estado):
    for atr in atracciones:
        if atr.estado == estado:
            mostrar_informacion(atr)

# Función para mostrar la información de una atracción
def mostrar_informacion(atraccion):
    print(f"Nombre: {atraccion.nombre}")
    print(f"Estatura Mínima: {atraccion.estaturaMinima}")
    print(f"Nivel: {atraccion.nivel}")
    print(f"Restricciones: {atraccion.restricciones}")
    print(f"Estado: {'Activa' if atraccion.estado else 'Inactiva'}")
    print()

# Función para guardar la lista de atracciones en un archivo de texto
def guardar_en_archivo(lista_atracciones, archivo):
    with open(archivo, 'w') as f:
        for atr in lista_atracciones:
            f.write(f"{atr.nombre},{atr.estaturaMinima},{atr.nivel},{','.join(atr.restricciones)},{atr.estado}\n")

# Función para cargar la lista de atracciones desde un archivo de texto
def cargar_desde_archivo(archivo):
    try:
        with open(archivo, 'r') as f:
            lineas = f.readlines()
            lista_atracciones = []
            for linea in lineas:
                datos = linea.strip().split(',')
                nombre = datos[0]
                estatura = float(datos[1])
                nivel = int(datos[2])
                restricciones = datos[3].split(',')
                estado = datos[4].lower() == 'true'
                atraccion = Atraccion(nombre, estatura, nivel, restricciones, estado)
                lista_atracciones.append(atraccion)
            return lista_atracciones
    except FileNotFoundError:
        return []

# Menú principal
if __name__ == "__main__":
    archivo_atracciones = "atracciones.txt"
    lista_atracciones = cargar_desde_archivo(archivo_atracciones)

    while True:
        print("\n----- Menú -----")
        print("1. Insertar atracción")
        print("2. Eliminar atracción")
        print("3. Actualizar atracción")
        print("4. Buscar atracciones activas")
        print("5. Buscar atracciones inactivas")
        print("6. Salir")

        opcion = input("Ingrese la opción deseada: ")

        if opcion == "1":
            nombre = input("Ingrese el nombre de la atracción: ")
            estatura = float(input("Ingrese la estatura mínima: "))
            nivel = int(input("Ingrese el nivel (1=bajo, 2=medio, 3=alto): "))
            restricciones = []
            while True:
                restriccion = input("Ingrese una restricción (escriba NO para terminar): ")
                if restriccion.upper() == "NO":
                    break
                restricciones.append(restriccion)
            estado = True
            nueva_atraccion = Atraccion(nombre, estatura, nivel, restricciones, estado)
            insertar(nueva_atraccion, lista_atracciones, archivo_atracciones)

        elif opcion == "2":
            nombre_eliminar = input("Ingrese el nombre de la atracción a eliminar: ")
            eliminar(nombre_eliminar, lista_atracciones, archivo_atracciones)

        elif opcion == "3":
            nombre_actualizar = input("Ingrese el nombre de la atracción a actualizar: ")
            estatura_nueva = float(input("Ingrese la nueva estatura mínima: "))
            nivel_nuevo = int(input("Ingrese el nuevo nivel (1=bajo, 2=medio, 3=alto): "))
            restricciones_nuevas = []
            while True:
                restriccion_nueva = input("Ingrese una restricción (escriba NO para terminar): ")
                if restriccion_nueva.upper() == "NO":
                    break
                restricciones_nuevas.append(restriccion_nueva)
            estado_nuevo = input("La atracción estará activa? (Sí/No): ").upper() == "SÍ"
            actualizar(nombre_actualizar, estatura_nueva, nivel_nuevo, restricciones_nuevas, estado_nuevo, lista_atracciones, archivo_atracciones)

        elif opcion == "4":
            buscar(lista_atracciones, True)

        elif opcion == "5":
            buscar(lista_atracciones, False)

        elif opcion == "6":
            break

        else:
            print("Opción no válida. Intente de nuevo.")

