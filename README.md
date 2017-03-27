# PowerShell-Icinga2

## Build status
| Master | Development | Latest |
|--------|-------------|--------|
|[![Build status](https://ci.appveyor.com/api/projects/status/github/theflyingcorpse/powershell-icinga2?branch=master&retina=true)](https://ci.appveyor.com/project/TheFlyingCorpse/powershell-icinga2/branch/master) | [![Build Status](https://ci.appveyor.com/api/projects/status/github/theflyingcorpse/powershell-icinga2?branch=development&retina=true)](https://ci.appveyor.com/project/TheFlyingCorpse/powershell-icinga2/branch/development) | [![Build status](https://ci.appveyor.com/api/projects/status/2uhnk7352gao3e8k?retina=true)](https://ci.appveyor.com/project/TheFlyingCorpse/powershell-icinga2)

## Style and stuff
PoshCode guidelines.

## Roadmap 
### 0.1 - Currently here

Completed:
- Basic ticket registration against an Icinga2 CA via ticket.
- Skeleton is copied in if it does not exist.

ToDo:
- Agnostic to where Icinga2 is installed:
  - AppX (Done)
  - Binary (Done)
  - MSI
- Zone and Endpoint creation with configuration for upstream.

### 0.2
- Tests with AppVeyor.
- Feature list, enable and disable.
- Feature configuration:
  - API
- Parse configuration:
  - Needs scoping. Useful for Zones, Endpoints and Features.
  
### 0.3
- Query Icinga2 API support to fetch what is in the configuration.
- Use Windows CA / ADCS for certificate enrollment as a 3rd party CA similar to PuppetCA.

### 0.4
- Desired State Configuration.

### Not scoped
- Support for more than Windows using PowerShell Core
- Icinga2 API integration
  - Needs scoping. Ideally it could do anything the API allows for, to start with querying for whatever is configured seems feasible.