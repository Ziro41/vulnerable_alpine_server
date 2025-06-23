Este es un servidor vulnerable mediante un cronjob

Tiene un usuario ziro con la contraseña Oracle1010 (Habria que añadir los usuarios sin privilegios)

En el siguiente path /usr/local/bin/cleanup_temp.py se encuentra un script de python que se ejecuta con privilegios cada minuto y puede ser editado por cualquiera.
La idea es acceder a algun usuario tras haber obtenido las credenciales y obtener los contenidos del archivo knockd.conf con la secuencia de puertos, para asi editar el script de python del cron job y escalar privilegios


Para ejecutarlo se puede correr el archivo build_run_container.sh que creara la imagen y el container. (Esto en linux)
Y luego dentro del container correr el archivo startup.sh 
