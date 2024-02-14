#Angie Vargas Matarrita
#Depurado de datos usando Pandas
import pandas
import datetime

print ('Inicio:',datetime.datetime.now())
df=pandas.read_csv(r"C:/datos/clase2.csv")
print ('Cargado:',datetime.datetime.now())
print (df.head(10))
print('')
print(df.info())
print ('')

print ('Depurando:',datetime.datetime.now())
print(df.duplicated())
print()
df.dropna(inplace = True)
print(df)
print()
print ('Finalizado:',datetime.datetime.now())