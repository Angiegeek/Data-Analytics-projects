#Angie Vargas 
#Repaso de ciclos
#Universidad Cenfotec

"""Ejercicio 1 """  
numero=int(input("Elija un número"))
"""variables"""
x=1
y=0
"""ciclo while"""
while x <=numero:
    """Condicionales"""
    if numero % x == 0:
        y=y+1
    x=x+1 
if y==2:
    print("El número",numero,"es primo")
else:
    print("El número", numero, "no es primo")
    
""""Ejercicio 2"""    
    
frase = input("Frase: ")
letra = input("Letra")
contador = 0
for i in frase:
    if i == letra:
        contador += 1
print("La letra '%s' aparece %2i veces en la frase '%s'." % (letra, contador, frase))   
    
"""Ejercicio 3 """
numero = int(input("Elija un número positivo "))
for variable in range(numero, -1, -1):
    print(variable, end=", ")
      
            