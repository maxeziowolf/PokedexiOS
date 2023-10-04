# Pokedex App

  
La Pokedex App es una aplicación iOS que te permite explorar un listado de Pokémon y ver los detalles de cada uno. Esta aplicación se encuentra en desarrollo y actualmente presenta el listado de los Pokémon y la vista de detalle completamente funcional. 

La Pokedex App integra muchos avances en el desarrollo de vistas programáticas, lo que permite una construcción de interfaz de usuario más eficiente y flexible. Además, utiliza el patrón de diseño MVVM (Model-View-ViewModel) y sigue los principios de Clean Architecture para mantener una estructura de código limpia y modular. 

La aplicación utiliza Combine, un marco de programación reactiva de Apple, para gestionar la lógica asíncrona y la comunicación con la API. También se conecta a la [PokeAPI](https://pokeapi.co/), una API pública que proporciona información detallada sobre los Pokémon.

## Capturas del proyecto 📷 

<h2>Pantalla inicial/Listado de pókemones</h2>
<div align="center" >
  <img src="/screenshots/ImagenPrincpal.png" alt="ImagenPrincipal" width="400" height="800" align="center" >
</div>

</br>

<h2>Consulta de pókemon</h2>
<div align="center" >
  <img src="/screenshots/consultadepersonajes1.png" alt="Variante" width="400" height="800" align="center" >
  <img src="/screenshots/consultadepersonajes2.png" alt="Variante1" width="400" height="800" align="center" >
</div>

<h2>Gif del funcionamiento</h2>
<div align="center">  <img src="/screenshots/pokedex_gif.gif" alt="GIF" width="200" height="400">  </div>

## 💭 Inspiration

La inspiración para este proyecto proviene de la nostalgia y el amor por la franquicia de Pokémon. Queríamos crear una aplicación que permitiera a los fanáticos de todas las edades explorar y conocer más sobre sus Pokémon favoritos. 

Con inspiración en el diseño obtenida gracias a: 
-   Design inspired by  [Pokedex App design](https://dribbble.com/shots/6563578-Pokedex-App-Animation)  mabe by  [Saepul Nahwan](https://www.instagram.com/saepulnahwan/).

## Requirements

- Xcode 13.0 o superior
- iOS 13.0 o superior
- Conexión a Internet para cargar datos de Pokémon
- Xcode para compilar el proyecto o instalarlo en un dispositivo fisico.


## 🔨 Technologies

Este proyecto se ha desarrollado utilizando las siguientes tecnologías:

- Swift: El lenguaje de programación principal para el desarrollo de aplicaciones iOS.
- UIKit: Framework de interfaz de usuario utilizado para construir la interfaz de usuario de la aplicación.
- [ServiceCoordinator](https://github.com/maxeziowolf/ServiceCoordinator): Un componente de ServiceCoordinator, desarrollado por el autor del proyecto, que se utiliza para gestionar la navegación y la coordinación de servicios en la aplicación.
- CoreData: Utilizado para almacenar información en caché y mejorar la velocidad de la aplicación.
- MVVM (Model-View-ViewModel): Patrón de diseño utilizado para separar la lógica de la vista.
- Arquitectura limpia (Clean Architecture): Metodología que promueve una estructura de código limpia y modular, fomentando la separación de responsabilidades y la escalabilidad del proyecto.
- Xcode: El entorno de desarrollo integrado (IDE) de Apple utilizado para desarrollar la aplicación iOS.
- Combine: Utilizado para gestionar la lógica asíncrona y la comunicación con la API.
- SwiftLint: Herramienta de análisis estático que ayuda a mantener un código Swift limpio y consistente.


## Features

- Listado de Pokémon: Muestra una lista de Pokémon con sus nombres y números de Pokédex.
- Detalles de Pokémon: Permite ver los detalles de un Pokémon específico, incluyendo su tipo, habilidades y estadísticas.

## Contribuciones

¡Estamos abiertos a contribuciones! Si deseas contribuir a este proyecto, por favor, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una rama para tu nueva característica (`git checkout -b feature/nueva-caracteristica`).
3. Realiza tus cambios y haz commits (`git commit -m 'Añadir nueva característica'`).
4. Hacer un push a tu rama (`git push origin feature/nueva-caracteristica`).
5. Crea una solicitud de extracción (Pull Request) en GitHub.

Esperamos recibir contribuciones que mejoren la aplicación y la experiencia de los usuarios.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para obtener más detalles.

¡Gracias por tu interés en la Pokedex App!
