# OrionTek Address Manager

Aplicación iOS para la gestión de clientes y sus direcciones, desarrollada como prueba técnica para OrionTek.

##  Preview

<p align="center">
  <img src="Screenshots/clients-list.png" width="200" alt="Lista de Clientes"/>
  <img src="Screenshots/client-list-filter.png" width="200" alt="Búsqueda"/>
  <img src="Screenshots/client-detail.png" width="200" alt="Detalle del Cliente"/>
  <img src="Screenshots/new-client.png" width="200" alt="Nuevo Cliente"/>
  <img src="Screenshots/new-address.png" width="200" alt="Nueva Dirección"/>
  <img src="Screenshots/delete-client.png" width="200" alt="Eliminar Cliente"/>
</p>


##  Características

-  **Gestión completa de clientes** - Crear, leer, actualizar y eliminar clientes
-  **Múltiples direcciones por cliente** - Cada cliente puede tener N direcciones
-  **Búsqueda en tiempo real** - Filtrado instantáneo por nombre de cliente
-  **Dirección principal** - Marcado de dirección principal (solo una por cliente)
-  **Persistencia local** - Los datos se guardan automáticamente con UserDefaults
-  **Avatares dinámicos** - Iniciales con gradientes únicos por cliente

##  Tecnologías

- **Swift 5.9+**
- **SwiftUI** - Framework declarativo de UI
- **MVVM** - Arquitectura Model-View-ViewModel
- **Codable** - Serialización JSON
- **UserDefaults** - Persistencia local
- **Xcode 16.4**
- **iOS 17.0+**

##  Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/JeromyMD/OrionTek-Address-Manager-.git
```

2. Abrir el proyecto:
```bash
cd OrionTek-Address-Manager-
open OrionTek_Address_Gestor.xcodeproj
```

3. Ejecutar en el simulador o dispositivo físico:
   - Seleccionar un simulador 
   - Presionar `⌘ + R` o click en el botón Play

**Nota:** No requiere dependencias externas ni CocoaPods/SPM.

##  Arquitectura

El proyecto sigue el patrón **MVVM (Model-View-ViewModel)** con separación clara de responsabilidades:
