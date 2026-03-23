# COMO INICIAR EL PROYECTO CON LA API  

Para iniciar el proyecto se requieren 3 cosas  
La DB MySQL  
La DB MongoDB  
La API corriendo (necesita los 2 de arriba)  

## MySQL  
`1. Iniciar workbench o importar el dump
Si se quiere usar el script, solo se copia dentro de workbench y se corre completo.`  
    
`2. Con la base de datos creada (sistema_inventario) 
Asegurarse que el servicio de MySQL esté corriendo
(Task Manager -> Servicios -> MySQL80, depende la version de MySQL Server Instalada - No Workbench)`  

## MongoDB
### Primera Opcion  
`Si tienen los comandos de mongosh, solo ejecutan mongosh mongodb-scripts.js`
  
### Segunda Opcion  
`Iniciar Compass, conectarse a root, crear nueva base de datos y crean una coleccion cualquiera que puedan borrar despues solo para dejar que la creen, abrir powershell dentro de compass habiendo elegido sistema_inventario`  ``` (>_ Open MongoDB shell)```  
`copian todo el contenido del js menos use  sistema_inventario;`  
`Lo pegan en el shell y dan ENTER, deberia crearles la DB con todos los datos, refresh Compass para comprobar`

## API
`La API se puede correr de 2 formas`  

### Primera Opcion
`Crean un .env, copian el contenido de .env_example y ponen sus credenciales, luego le dan npm start en la terminal, verifican que conecte`  
  
### Segunda Opcion
`Abren el .exe llamado api-inventario.exe, les va a pedir sus credenciales la primera vez y deberia salir conexion existosa si todo esta corriendo como debe de las 2 bases de datos`  
  
### Precaucion
`El .exe es para windows, si tienen otro OS como linux o macos, pueden correr en la terminal del proyecto npm run build:macos o linux en vez de macos (Viene explicado en Guia.md dentro de API)`  
