# Bus2 - Flutter Application

Uma aplicação Flutter moderna desenvolvida seguindo os princípios de Clean Architecture e padrão MVVM, com foco em escalabilidade, manutenibilidade e boas práticas de desenvolvimento.

## Visão Geral

Bus2 é uma aplicação Flutter que implementa uma arquitetura robusta para gerenciamento de usuários, utilizando as melhores práticas da comunidade Flutter e padrões de arquitetura estabelecidos.

## Arquitetura

### Clean Architecture

O projeto segue os princípios da Clean Architecture, organizando o código em camadas bem definidas:

- **Domain Layer**: Contém as entidades de negócio e DTOs
- **Data Layer**: Implementa repositórios, serviços e gerenciamento de dados
- **UI Layer**: Responsável pela interface do usuário e ViewModels

### MVVM (Model-View-ViewModel)

A arquitetura MVVM é implementada através de:

- **Model**: Entidades e DTOs na camada de domínio
- **View**: Widgets e páginas da UI
- **ViewModel**: Classes que gerenciam o estado e lógica de apresentação

#### Vantagens do MVVM:
- Separação clara de responsabilidades
- Facilita testes unitários
- Reutilização de lógica de negócio
- Melhor manutenibilidade do código

## Estrutura do Projeto

```
lib/
├── config/
│   └── injectors.dart              # Configuração de injeção de dependências
├── data/
│   ├── exceptions/                 # Exceções customizadas
│   ├── repositories/               # Implementação dos repositórios
│   └── services/                   # Serviços de dados (HTTP, LocalStorage)
├── domain/
│   ├── dtos/                      # Data Transfer Objects
│   └── entities/                  # Entidades de domínio
├── ui/
│   ├── home_page.dart             # Página principal
│   ├── splash/                    # Tela de splash
│   │   └── splash_page.dart
│   └── user/                      # Módulo de usuários
│       ├── user_details_page.dart # Detalhes do usuário
│       └── user_saved_page.dart   # Usuários salvos
├── utils/
│   ├── components/                # Componentes reutilizáveis
│   ├── exceptions/                # Exception customizada
│   ├── helpers/                   # Funções auxiliares
│   └── widgets/                   # Widgets customizados
├── viewmodels/                    # ViewModels (MVVM)
│   ├── ticker_viewmodel.dart      # ViewModel para ticker
│   └── user_viewmodel.dart        # ViewModel para usuários
├── main.dart                      # Ponto de entrada da aplicação
├── main.g.dart                    # Arquivo gerado (rotas)
└── main.route.dart                # Configuração de rotas
```

### Páginas da Aplicação

#### 🚀 Splash Page
- **Localização**: `lib/ui/splash/splash_page.dart`
- **Propósito**: Tela inicial de carregamento da aplicação com animações elegantes
- **Funcionalidades principais**:
  - **Design moderno**: Interface com fundo gradiente escuro e elementos minimalistas
  - **Animação fluida**: Efeito de fade-in controlado por AnimationController
  - **Ícone da aplicação**: Exibe o ícone de ônibus (Bus2) com design responsivo
  - **Indicador de progresso**: Loading spinner animado durante inicialização
  - **Navegação automática**: Redirecionamento automático para a tela principal após 2.2 segundos
  - **Paleta de cores personalizada**: Sistema de cores consistente (AppColors)
  - **Responsividade**: Layout adaptativo para diferentes tamanhos de tela

#### 🏠 Home Page
- **Localização**: `lib/ui/home_page.dart`
- **Propósito**: Gerenciamento de usuários e sistema de ticker
- **Funcionalidades principais**:
  - **Lista de usuários dinâmica**: Exibição de usuários carregados da API RandomUser
  - **Sistema de ticker inteligente**: Contador regressivo (5s) para atualização automática
  - **Controles de ticker**: Botões para pausar/retomar e atualizar manualmente
  - **AppBar customizada**: Com contador de usuários e status do ticker em tempo real
  - **Estados de loading**: Shimmer effects elegantes durante carregamentos
  - **Cards de usuário**: Interface intuitiva com foto, nome, email e botão de favoritar
  - **Navegação contextual**: Acesso direto aos detalhes do usuário e usuários salvosgit 
  - **Tratamento de erros**: Feedback visual para falhas de carregamento
  - **Design responsivo**: Layout otimizado com ScrollView e RefreshIndicator
  - **Boas vindas**: Mensagem personalizada quando não há usuários carregados

#### 👤 User Details Page  
- **Localização**: `lib/ui/user/user_details_page.dart`
- **Propósito**: Visualização completa e interativa dos dados detalhados do usuário
- **Funcionalidades principais**:
  - **Perfil completo**: Avatar grande com bordas coloridas baseadas no gênero
  - **Informações pessoais**: Nome completo, idade, gênero e nacionalidade
  - **Dados de contato**: Email, telefone com formatação adequada
  - **Endereço completo**: Rua, cidade, estado, país e CEP organizados em seções
  - **Credenciais de login**: Username com opção de mostrar/ocultar senha
  - **Data de nascimento**: Formatação legível com idade calculada
  - **Sistema de favoritos**: Toggle para salvar/remover usuário dos favoritos
  - **Feedback visual**: Badges coloridas e ícones contextuais
  - **Seções organizadas**: Layout em cards com informações agrupadas logicamente
  - **Navegação fluida**: AppBar com botão voltar e ações contextuais
  - **Estados visuais**: Indicadores de carregamento e confirmação de ações

#### 💾 User Saved Page
- **Localização**: `lib/ui/user/user_saved_page.dart`  
- **Propósito**: Gerenciamento e visualização de usuários salvos localmente
- **Funcionalidades principais**:
  - **Lista de favoritos**: Exibição de todos os usuários salvos no dispositivo
  - **Persistência local**: Dados armazenados via SharedPreferences
  - **Ticker pausado**: Interface otimizada sem atualizações automáticas
  - **Remoção de favoritos**: Ação de desfavoritar diretamente da lista
  - **Estados vazios**: Mensagem informativa quando não há usuários salvos
  - **AppBar informativa**: Contador de usuários salvos em tempo real
  - **Cards interativos**: Interface consistente com a Home Page
  - **Navegação contextual**: Acesso aos detalhes de cada usuário salvo
  - **Feedback de ações**: SnackBars para confirmação de operações
  - **Layout responsivo**: ScrollView com RefreshIndicator para atualizações
  - **Tratamento de erros**: Mensagens claras para falhas de carregamento
  - **Performance otimizada**: Carregamento eficiente dos dados locais

## Packages e Dependências

### Dependências Principais

#### `routefly: ^3.1.3`
**Propósito**: Gerenciamento avançado de rotas
- Roteamento declarativo e type-safe
- Geração automática de rotas
- Navegação simplificada entre telas

#### `auto_injector: ^2.1.1`
**Propósito**: Injeção de dependências
- Container de DI leve e performático
- Gerenciamento automático do ciclo de vida
- Facilita testes e desacoplamento

#### `result_dart: ^2.1.1`
**Propósito**: Tratamento funcional de resultados
- Elimina exceções não tratadas
- Facilita o tratamento de erros
- Programação funcional para operações assíncronas

#### `result_command: ^2.2.0`
**Propósito**: Implementação do padrão Command
- Encapsula operações assíncronas
- Estados de loading, success e error
- Integração perfeita com result_dart

#### `dio: ^5.9.0`
**Propósito**: Cliente HTTP avançado
- Interceptors para logs e autenticação
- Retry automático em falhas
- Timeout e cache configuráveis

#### `shared_preferences: ^2.5.3`
**Propósito**: Persistência local de dados
- Armazenamento key-value simples
- Dados persistem entre sessões
- Ideal para configurações e cache

## Padrões de Desenvolvimento

### Repository Pattern
- Abstração da camada de dados
- Interface única para diferentes fontes de dados
- Facilita testes e mocks

### Command Pattern
- Encapsula operações complexas
- Estados de execução bem definidos
- Facilita desfazer operações

### Dependency Injection
- Baixo acoplamento entre componentes
- Facilita testes unitários
- Configuração centralizada

## Como Executar

### Pré-requisitos
- Flutter SDK 3.9.2 ou superior
- Dart SDK compatível
- IDE com suporte Flutter (VS Code, Android Studio)

### Instalação
```bash
# Clone o repositório
git clone <repository-url>

# Navegue para o diretório
cd bus2

# Instale as dependências
flutter pub get

# Execute a geração de código
flutter packages pub run build_runner build

# Execute a aplicação
flutter run
```

### Build para Produção
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## Testes

```bash
# Executar todos os testes
flutter test

# Executar testes com cobertura
flutter test --coverage
```

## Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## Estrutura de Commit

Siga o padrão Conventional Commits:
- `feat:` nova funcionalidade
- `fix:` correção de bug
- `docs:` documentação
- `style:` formatação
- `refactor:` refatoração
- `test:` testes

## Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.
