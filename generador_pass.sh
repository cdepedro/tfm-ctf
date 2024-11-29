####################################################################################################
#### 			SCRIPT PARA LA GENERACIÓN DE CONTRASEÑAS A PARTIR DE OTRAS						####
#### 																							####
####	Con el siguiente script, se modifica la contraseña original de la siguiente forma:		####
#### 1. Se pasa todo a Mayúsculas																####
#### 2. Solo la pimera en Mayúsculas															####
#### 3. Se permutan los dos últimos caracteres													####
#### 4. Se añade numberación del 00 al 99														####
####################################################################################################
#!/bin/bash
input="pass.txt" 				# Fichero de contraseñas inicial
output="pass_extended.txt"		# Ficheros de contraseñas extendido
> $output

while IFS= read -r line; do
  # Agregar la palabra original
  echo "$line" >> $output		# Contraseña inicial se añade al fichero extendido
  echo "${line,,}" >> $output  	# Todo en minúsculas y se añade al fichero extendido
  echo "${line^^}" >> $output  	# Todo en mayúsculas y se añade al fichero extendido
  # La inicial en mayúsculas y se añade al fichero extendido
  echo "$(tr '[:lower:]' '[:upper:]' <<< ${line:0:1})${line:1}" >> $output  

  # Permutar los dos últimos caracteres y se añade al fichero extendido
  if [[ ${#line} -gt 1 ]]; then
    last_char="${line: -1}"
    second_last_char="${line: -2:1}"
    permuted="${line:0:${#line}-2}${last_char}${second_last_char}"
    echo "$permuted" >> $output
  fi
  
  # Añadir números del 00 al 99 al final de la palabra y se añade al fichero extendido
  for i in {00..99}; do
    echo "${line}${i}" >> $output
  done
done < "$input"
