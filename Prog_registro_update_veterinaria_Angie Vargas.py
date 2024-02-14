#Proyecto de Python
#Alumna Angie Vargas
#Universidad Cenfotec
#OBJETIVO: crear un programa para una "Veterinaria" en el cual
#Traiga un menu principal en el cual el usuario pueda registrar una mascota,
#definir alguna informacion, actualizarla y llevar el control de las mascotas atendidas
# al final podra salir de ser necesario

class Mascota:
    def __init__(self, codigo, nombre):
        self.codigo = codigo
        self.nombre = nombre
        self.enfermedades = []

    def agregar_enfermedad(self, enfermedad):
        self.enfermedades.append(enfermedad)

    def cambiar_nombre(self, nuevo_nombre):
        self.nombre = nuevo_nombre

    def perfil_clinico(self):
        print("Veterinaria San Martín")
        print(f"Fecha de adopción: {self.codigo[3:5]}/{self.codigo[5:7]}/{self.codigo[7:9]}")
        print(f"Numero de Adopción: {self.codigo[9:12]}")
        print(f"Nombre: {self.nombre}")
        print("Enfermedades:")
        for i, enfermedad in enumerate(self.enfermedades, 1):
            print(f"{i}. {enfermedad}")

class Veterinaria:
    def __init__(self):
        self.mascotas = []

    def registrar_mascota(self):
        # Paso 1: Solicitar código al usuario
        codigo = input("Ingrese el código (VSMDDMMAA###): ")

        # Paso 2: Validar el código
        if not self.validar_codigo(codigo):
            print("El código debe escribir “VSM” seguido de la fecha mes / dia / terminacion del año y un número consecutivo.")
            return

        # Paso 3: Solicitar nombre de la mascota
        nombre = input("Ingrese el nombre de la mascota: ")

        # Paso 4: Solicitar enfermedades hasta que el usuario decida terminar
        mascota = Mascota(codigo, nombre)
        while True:
            enfermedad = input("Ingrese una enfermedad (o 'fin' para terminar): ")
            if enfermedad.lower() == 'fin':
                break
            mascota.agregar_enfermedad(enfermedad)

        # Paso 5: Agregar la mascota a la lista de mascotas
        self.mascotas.append(mascota)
        print("Mascota registrada exitosamente.")

    def validar_codigo(self, codigo):
        return codigo.startswith("VSM",0,3)

    def cambiar_nombre_mascota(self):
        # Paso 1: Solicitar código al usuario
        codigo = input("Ingrese el código de la mascota a la que desea cambiar el nombre: ")

        # Paso 2: Buscar la mascota por código
        mascota = self.buscar_mascota_por_codigo(codigo)

        # Paso 3: Si se encuentra la mascota, solicitar el nuevo nombre y cambiarlo
        if mascota:
            nuevo_nombre = input("Ingrese el nuevo nombre: ")
            mascota.cambiar_nombre(nuevo_nombre)
            print("Nombre cambiado exitosamente.")
        else:
            print("Mascota no encontrada.")

    def agregar_enfermedad_mascota(self):
        # Paso 1: Solicitar código al usuario
        codigo = input("Ingrese el código de la mascota a la que desea agregar una enfermedad: ")

        # Paso 2: Buscar la mascota por código
        mascota = self.buscar_mascota_por_codigo(codigo)

        # Paso 3: Si se encuentra la mascota, solicitar la nueva enfermedad y agregarla
        if mascota:
            enfermedad = input("Ingrese la nueva enfermedad: ")
            mascota.agregar_enfermedad(enfermedad)
            print("Enfermedad agregada exitosamente.")
        else:
            print("Mascota no encontrada.")

    def listar_mascotas_atendidas(self, mes, ano):
        print(f"Mascotas atendidas en {mes}/{ano}:")
        for mascota in self.mascotas:
            if mascota.codigo[5:7] == mes and mascota.codigo[7:9] == ano:
                print(f"Nombre: {mascota.nombre}")
                print("Enfermedades:")
                for i, enfermedad in enumerate(mascota.enfermedades, 1):
                    print(f"{i}. {enfermedad}")
                print()

    def buscar_mascota_por_codigo(self, codigo):
        for mascota in self.mascotas:
            if mascota.codigo == codigo:
                return mascota
        return None

if __name__ == "__main__":
    veterinaria = Veterinaria()

    while True:
        print("\n")
        print("Bienvenidos a la Veterinaria San Martín")
        print("\nMenu Principal")
        print("\n1. Registrar mascota")
        print("2. Determinar perfil clínico de una mascota")
        print("3. Cambiar nombre de mascota")
        print("4. Enfermedades de las mascotas")
        print("5. Mascotas atendidas")
        print("6. Salir")
        
        # Solicitar al usuario que elija una opción
        opcion = input("Elija una opción (1-6): ")

        # Realizar la acción correspondiente según la opción seleccionada
        if opcion == '1':
            veterinaria.registrar_mascota()
        elif opcion == '2':
            codigo = input("Ingrese el código de la mascota: ")
            mascota = veterinaria.buscar_mascota_por_codigo(codigo)
            if mascota:
                mascota.perfil_clinico()
            else:
                print("Mascota no encontrada.")
        elif opcion == '3':
            veterinaria.cambiar_nombre_mascota()
        elif opcion == '4':
            veterinaria.agregar_enfermedad_mascota()
        elif opcion == '5':
            mes = input("Ingrese el mes (MM): ")
            ano = input("Ingrese el año (AA): ")
            veterinaria.listar_mascotas_atendidas(mes, ano)
        elif opcion == '6':
            print("Saliendo del programa. ¡Hasta luego!")
            break
        else:
            print("Opción no válida. Intente de nuevo.")