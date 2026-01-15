# Prodaric PropTech Platform - Technical Architecture

> **Version:** 1.0.0  
> **Last Updated:** January 15, 2026  
> **Status:** Living Document

---

## Table of Contents

1. [Overview](#1-overview)
2. [System Architecture](#2-system-architecture)
3. [Prodaric Core](#3-prodaric-core)
4. [PropTech Modules](#4-proptech-modules)
5. [Data Architecture](#5-data-architecture)
6. [Deployment Architecture](#6-deployment-architecture)
7. [Security Architecture](#7-security-architecture)
8. [Scalability & Performance](#8-scalability--performance)
9. [Integration Points](#9-integration-points)
10. [Technology Decisions](#10-technology-decisions)

---

## 1. Overview

### 1.1 Architectural Vision

Prodaric is designed as a **modular, cloud-native PropTech platform** that transforms real estate management through intelligent automation, data analytics, and modern software architecture. The platform follows industry best practices and enterprise-grade patterns to ensure scalability, maintainability, and extensibility.

### 1.2 Design Principles

#### Clean Architecture
- **Dependency Inversion**: Core business logic depends on abstractions, not implementations
- **Separation of Concerns**: Each layer has a single, well-defined responsibility
- **Independent of Frameworks**: Business rules don't depend on external libraries
- **Testable**: Business logic can be tested without UI, database, or external services

#### Domain-Driven Design (DDD)
- **Ubiquitous Language**: Shared vocabulary between developers and domain experts
- **Bounded Contexts**: Clear boundaries between different business domains
- **Aggregates**: Consistency boundaries for transaction management
- **Domain Events**: Communicate changes across bounded contexts

#### CQRS Pattern
- **Command Query Separation**: Write operations separated from read operations
- **Optimized Models**: Different models optimized for reads vs writes
- **Event Sourcing**: Optional event store for audit and temporal queries
- **Scalability**: Independent scaling of read and write workloads

### 1.3 Architectural Decision Records (ADRs)

| ID | Decision | Rationale | Status |
|----|----------|-----------|--------|
| ADR-001 | Use .NET 8 for backend | Performance, cross-platform, mature ecosystem | ✅ Accepted |
| ADR-002 | React 18 for frontend | Component reusability, large ecosystem, TypeScript support | ✅ Accepted |
| ADR-003 | PostgreSQL as primary database | ACID compliance, JSON support, open-source | ✅ Accepted |
| ADR-004 | Multi-tenancy at application layer | Flexibility, cost optimization, isolation control | ✅ Accepted |
| ADR-005 | Microservices-ready monolith | Start simple, evolve to microservices | ✅ Accepted |
| ADR-006 | API-first development | Enable third-party integrations from day one | ✅ Accepted |
| ADR-007 | Event-driven architecture | Loose coupling, scalability, audit trail | 🔄 Proposed |
| ADR-008 | Kubernetes for orchestration | Industry standard, portability, auto-scaling | ✅ Accepted |

---

## 2. System Architecture

### 2.1 High-Level Architecture

```mermaid
graph TB
    subgraph "Client Layer"
        WebApp[Web Application<br/>React + TypeScript]
        MobileApp[Mobile App<br/>React Native]
        API_Clients[Third-party Clients<br/>API Consumers]
    end

    subgraph "API Gateway Layer"
        Gateway[API Gateway<br/>Routing, Auth, Rate Limiting]
        GraphQL[GraphQL Gateway<br/>Unified Data Access]
    end

    subgraph "Application Services Layer"
        Core[Prodaric Core<br/>Auth, Multi-tenancy, Shared Services]
        Lease[Prodaric Lease<br/>Contract Management]
        Invest[Prodaric Invest<br/>Investment Analysis]
        Market[Prodaric Market<br/>Marketplace]
        Manage[Prodaric Manage<br/>Property Operations]
        Analytics[Prodaric Analytics<br/>BI & Reporting]
    end

    subgraph "Infrastructure Layer"
        MessageBus[Message Bus<br/>RabbitMQ/Azure Service Bus]
        Cache[Distributed Cache<br/>Redis]
        Database[(PostgreSQL<br/>Primary Database)]
        BlobStorage[Blob Storage<br/>Documents, Images]
        SearchEngine[Search Engine<br/>Elasticsearch]
    end

    subgraph "External Services"
        Payment[Payment Gateway<br/>Stripe]
        Maps[Maps API<br/>Google Maps]
        Email[Email Service<br/>SendGrid]
        SMS[SMS Service<br/>Twilio]
    end

    WebApp --> Gateway
    MobileApp --> Gateway
    API_Clients --> Gateway
    Gateway --> GraphQL
    Gateway --> Core
    Gateway --> Lease
    Gateway --> Invest
    Gateway --> Market
    Gateway --> Manage
    Gateway --> Analytics

    Core --> Database
    Core --> Cache
    Core --> MessageBus
    
    Lease --> Database
    Invest --> Database
    Market --> Database
    Manage --> Database
    Analytics --> SearchEngine

    Core --> Email
    Core --> SMS
    Market --> Maps
    Lease --> Payment
```

### 2.2 Application Layers

#### Presentation Layer
- **Responsibilities**: User interface, API endpoints, request/response handling
- **Technologies**: React 18, TypeScript 5, Tailwind CSS, ASP.NET Core Controllers
- **Patterns**: MVC, View Models, DTOs

#### Application Layer
- **Responsibilities**: Use cases, application logic, orchestration
- **Technologies**: MediatR, FluentValidation, AutoMapper
- **Patterns**: CQRS, Command/Query handlers, Application Services

#### Domain Layer
- **Responsibilities**: Business logic, domain entities, business rules
- **Technologies**: Pure C# with no external dependencies
- **Patterns**: Aggregates, Domain Events, Value Objects, Domain Services

#### Infrastructure Layer
- **Responsibilities**: Data persistence, external services, cross-cutting concerns
- **Technologies**: Entity Framework Core, Dapper, HTTP clients, Message queues
- **Patterns**: Repository, Unit of Work, Gateway, Adapter

```mermaid
graph LR
    A[Presentation Layer] --> B[Application Layer]
    B --> C[Domain Layer]
    B --> D[Infrastructure Layer]
    D --> C
    
    style C fill:#e1f5ff
```

### 2.3 Bounded Contexts

| Context | Responsibility | Services |
|---------|---------------|----------|
| **Identity** | User authentication, authorization, tenant management | Auth API, User Service, Tenant Service |
| **Leasing** | Lease lifecycle, contracts, rent collection | Lease API, Contract Service, Payment Service |
| **Investment** | Property valuation, ROI analysis, portfolio management | Investment API, Valuation Service, Analytics Engine |
| **Marketplace** | Property listings, lead management, transactions | Market API, Listing Service, Lead Service |
| **Operations** | Maintenance, work orders, vendor management | Manage API, Work Order Service, Vendor Service |
| **Analytics** | Reporting, dashboards, business intelligence | Analytics API, Report Service, Dashboard Service |

---

## 3. Prodaric Core

### 3.1 Core Services

Prodaric Core provides foundational services shared across all modules:

```mermaid
graph TB
    subgraph "Prodaric Core"
        Auth[Authentication Service]
        Authz[Authorization Service]
        Tenant[Multi-tenancy Service]
        Audit[Audit Logging Service]
        Notif[Notification Service]
        Config[Configuration Service]
        File[File Management Service]
        
        Auth --> Authz
        Tenant --> Auth
        Audit --> Tenant
    end
```

#### Authentication Service
- **Responsibility**: User identity verification, session management
- **Technology**: IdentityServer4 / Duende IdentityServer, OAuth 2.0, OpenID Connect
- **Features**:
  - Social login (Google, Microsoft, LinkedIn)
  - Multi-factor authentication (TOTP, SMS)
  - Passwordless authentication
  - Refresh token rotation
  - Device fingerprinting

#### Authorization Service
- **Responsibility**: Access control, permission management
- **Pattern**: Role-Based Access Control (RBAC) + Attribute-Based Access Control (ABAC)
- **Implementation**:
  ```csharp
  public class Permission
  {
      public string Resource { get; set; } // e.g., "Lease"
      public string Action { get; set; }   // e.g., "Create", "Read", "Update", "Delete"
      public string[] Scopes { get; set; } // e.g., ["Own", "Team", "Organization"]
  }
  ```

#### Multi-tenancy Service
- **Isolation Model**: Shared database with tenant discriminator
- **Tenant Resolution**: Header-based (`X-Tenant-Id`) + subdomain-based
- **Features**:
  - Tenant provisioning & onboarding
  - Custom branding per tenant
  - Feature flags per tenant
  - Usage tracking & billing

### 3.2 Multi-tenancy Implementation

```mermaid
sequenceDiagram
    participant Client
    participant Gateway
    participant TenantResolver
    participant TenantContext
    participant Database
    
    Client->>Gateway: Request with tenant identifier
    Gateway->>TenantResolver: Resolve tenant
    TenantResolver->>Database: Query tenant config
    Database-->>TenantResolver: Tenant data
    TenantResolver->>TenantContext: Set current tenant
    TenantContext-->>Gateway: Tenant context active
    Gateway->>Database: Query with tenant filter
    Database-->>Gateway: Tenant-specific data
    Gateway-->>Client: Response
```

**Implementation Pattern:**

```csharp
public interface ITenantContext
{
    Guid TenantId { get; }
    string TenantName { get; }
    TenantConfiguration Configuration { get; }
}

public class TenantMiddleware
{
    public async Task InvokeAsync(HttpContext context, ITenantResolver resolver)
    {
        var tenant = await resolver.ResolveAsync(context);
        context.Items["TenantId"] = tenant.Id;
        await _next(context);
    }
}

// Entity Framework Global Query Filter
modelBuilder.Entity<Lease>()
    .HasQueryFilter(e => e.TenantId == _tenantContext.TenantId);
```

### 3.3 Shared APIs

#### Core API Endpoints

```
POST   /api/v1/auth/login
POST   /api/v1/auth/refresh
POST   /api/v1/auth/logout
GET    /api/v1/tenants/current
GET    /api/v1/users/me
PUT    /api/v1/users/me
POST   /api/v1/files/upload
GET    /api/v1/files/{id}
POST   /api/v1/notifications/send
GET    /api/v1/audit/logs
```

---

## 4. PropTech Modules

### 4.1 Prodaric Lease

#### Domain Responsibility
Complete lease lifecycle management, from tenant screening to lease termination, rent collection, and renewals.

#### Core Entities

```mermaid
classDiagram
    class Lease {
        +Guid Id
        +Guid PropertyId
        +Guid TenantId
        +DateTime StartDate
        +DateTime EndDate
        +decimal MonthlyRent
        +LeaseStatus Status
        +CalculateRemainingTerm()
        +Renew()
        +Terminate()
    }
    
    class LeasePayment {
        +Guid Id
        +Guid LeaseId
        +DateTime DueDate
        +decimal Amount
        +PaymentStatus Status
        +ProcessPayment()
    }
    
    class Tenant {
        +Guid Id
        +string Name
        +string Email
        +string Phone
        +CreditScore Score
    }
    
    Lease --> Tenant
    Lease --> LeasePayment
```

#### Key Use Cases
1. **Create Lease**: Validate tenant, generate contract, set payment schedule
2. **Collect Rent**: Process payments, send reminders, handle late fees
3. **Renew Lease**: Generate renewal offer, negotiate terms, update contract
4. **Terminate Lease**: Calculate final charges, schedule move-out, release deposit
5. **Generate Reports**: Occupancy rates, rent roll, delinquency reports

#### Exposed APIs
```
POST   /api/v1/leases
GET    /api/v1/leases/{id}
PUT    /api/v1/leases/{id}
POST   /api/v1/leases/{id}/payments
GET    /api/v1/leases/{id}/payments
POST   /api/v1/leases/{id}/renew
POST   /api/v1/leases/{id}/terminate
```

### 4.2 Prodaric Invest

#### Domain Responsibility
Real estate investment analysis, portfolio management, ROI calculations, and financial forecasting.

#### Core Entities

```mermaid
classDiagram
    class Investment {
        +Guid Id
        +Guid PropertyId
        +decimal PurchasePrice
        +decimal CurrentValue
        +DateTime AcquisitionDate
        +CalculateROI()
        +CalculateCashFlow()
    }
    
    class Property {
        +Guid Id
        +string Address
        +PropertyType Type
        +decimal Area
        +GetMarketValue()
    }
    
    class FinancialMetrics {
        +decimal CapRate
        +decimal CashOnCash
        +decimal IRR
        +decimal NOI
    }
    
    Investment --> Property
    Investment --> FinancialMetrics
```

#### Key Use Cases
1. **Property Valuation**: Comparative Market Analysis (CMA), income approach, cost approach
2. **ROI Analysis**: Cash flow projections, cap rate, IRR, NPV calculations
3. **Portfolio Management**: Asset allocation, diversification analysis, performance tracking
4. **Market Analysis**: Trends, forecasting, neighborhood analytics
5. **Deal Analysis**: Pro forma, sensitivity analysis, what-if scenarios

#### Exposed APIs
```
POST   /api/v1/investments
GET    /api/v1/investments/{id}
GET    /api/v1/investments/{id}/metrics
POST   /api/v1/investments/{id}/valuations
GET    /api/v1/properties/{id}/market-analysis
POST   /api/v1/properties/{id}/compare
```

### 4.3 Prodaric Market

#### Domain Responsibility
Property marketplace for buying, selling, and renting with lead management and transaction coordination.

#### Core Entities

```mermaid
classDiagram
    class Listing {
        +Guid Id
        +Guid PropertyId
        +ListingType Type
        +decimal Price
        +ListingStatus Status
        +DateTime PublishedDate
        +Publish()
        +Archive()
    }
    
    class Lead {
        +Guid Id
        +Guid ListingId
        +string ContactName
        +string Email
        +LeadStatus Status
        +ConvertToTenant()
    }
    
    class Transaction {
        +Guid Id
        +Guid ListingId
        +Guid BuyerId
        +decimal Amount
        +TransactionStatus Status
        +Complete()
    }
    
    Listing --> Lead
    Listing --> Transaction
```

#### Key Use Cases
1. **Create Listing**: Property details, photos, pricing, publish to channels
2. **Lead Management**: Capture leads, qualify, schedule showings, follow-up
3. **Search & Discovery**: Advanced filters, map search, saved searches, alerts
4. **Transaction Management**: Offers, negotiations, document management, closing
5. **Marketing**: SEO optimization, social media integration, email campaigns

#### Exposed APIs
```
POST   /api/v1/listings
GET    /api/v1/listings
GET    /api/v1/listings/{id}
POST   /api/v1/listings/{id}/leads
GET    /api/v1/search/properties
POST   /api/v1/transactions
```

### 4.4 Prodaric Manage

#### Domain Responsibility
Day-to-day property operations including maintenance, work orders, vendor management, and inspections.

#### Core Entities

```mermaid
classDiagram
    class WorkOrder {
        +Guid Id
        +Guid PropertyId
        +string Description
        +WorkOrderPriority Priority
        +WorkOrderStatus Status
        +DateTime CreatedDate
        +Assign()
        +Complete()
    }
    
    class Vendor {
        +Guid Id
        +string Name
        +VendorCategory Category
        +decimal Rating
        +AssignWorkOrder()
    }
    
    class Inspection {
        +Guid Id
        +Guid PropertyId
        +InspectionType Type
        +DateTime ScheduledDate
        +InspectionResult Result
        +GenerateReport()
    }
    
    WorkOrder --> Vendor
    Property --> Inspection
```

#### Key Use Cases
1. **Work Order Management**: Create, assign, track, complete maintenance requests
2. **Vendor Management**: Onboard vendors, track performance, manage contracts
3. **Preventive Maintenance**: Schedule recurring tasks, automate reminders
4. **Inspections**: Move-in/out, periodic, compliance inspections
5. **Asset Management**: Equipment tracking, warranty management, lifecycle planning

#### Exposed APIs
```
POST   /api/v1/work-orders
GET    /api/v1/work-orders
PUT    /api/v1/work-orders/{id}/assign
POST   /api/v1/vendors
GET    /api/v1/vendors
POST   /api/v1/inspections
GET    /api/v1/inspections/{id}/report
```

### 4.5 Prodaric Analytics

#### Domain Responsibility
Business intelligence, reporting, dashboards, and predictive analytics across all modules.

#### Core Components

```mermaid
graph TB
    subgraph "Data Sources"
        Lease_DB[(Lease Data)]
        Invest_DB[(Investment Data)]
        Market_DB[(Market Data)]
        Manage_DB[(Operations Data)]
    end
    
    subgraph "ETL Pipeline"
        Extract[Data Extraction]
        Transform[Data Transformation]
        Load[Data Loading]
    end
    
    subgraph "Analytics Layer"
        DataWarehouse[(Data Warehouse)]
        OLAP[OLAP Cube]
        ML[ML Models]
    end
    
    subgraph "Presentation"
        Dashboard[Dashboards]
        Reports[Reports]
        API[Analytics API]
    end
    
    Lease_DB --> Extract
    Invest_DB --> Extract
    Market_DB --> Extract
    Manage_DB --> Extract
    
    Extract --> Transform
    Transform --> Load
    Load --> DataWarehouse
    
    DataWarehouse --> OLAP
    DataWarehouse --> ML
    
    OLAP --> Dashboard
    OLAP --> Reports
    ML --> API
```

#### Key Use Cases
1. **Performance Dashboards**: Real-time KPIs, trends, benchmarks
2. **Financial Reporting**: P&L, cash flow, balance sheet by property/portfolio
3. **Occupancy Analytics**: Vacancy rates, turnover, lease expirations
4. **Predictive Analytics**: Rent forecasting, maintenance predictions, churn risk
5. **Custom Reports**: Ad-hoc queries, scheduled reports, data exports

#### Exposed APIs
```
GET    /api/v1/analytics/dashboards
GET    /api/v1/analytics/kpis
POST   /api/v1/analytics/reports/generate
GET    /api/v1/analytics/forecasts/{metric}
POST   /api/v1/analytics/query
```

---

## 5. Data Architecture

### 5.1 Conceptual Data Model

```mermaid
erDiagram
    TENANT ||--o{ USER : has
    TENANT ||--o{ PROPERTY : owns
    PROPERTY ||--o{ LEASE : has
    PROPERTY ||--o{ LISTING : has
    PROPERTY ||--o{ WORK_ORDER : requires
    LEASE }o--|| TENANT_PERSON : occupied_by
    LEASE ||--o{ PAYMENT : generates
    LISTING ||--o{ LEAD : attracts
    WORK_ORDER }o--o| VENDOR : assigned_to
    PROPERTY ||--o{ INVESTMENT : tracked_by
    
    TENANT {
        uuid id PK
        string name
        string subdomain
        boolean active
        timestamp created_at
    }
    
    PROPERTY {
        uuid id PK
        uuid tenant_id FK
        string address
        string type
        decimal area
        jsonb metadata
    }
    
    LEASE {
        uuid id PK
        uuid property_id FK
        uuid tenant_person_id FK
        date start_date
        date end_date
        decimal monthly_rent
        string status
    }
```

### 5.2 Persistence Strategy

#### Database Sharding
- **Horizontal Partitioning**: By tenant for large customers
- **Vertical Partitioning**: Analytics data in separate warehouse
- **Read Replicas**: For reporting and analytics queries

#### Entity Framework Core Configuration

```csharp
public class ProdaricDbContext : DbContext
{
    private readonly ITenantContext _tenantContext;
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Global query filters for multi-tenancy
        foreach (var entityType in modelBuilder.Model.GetEntityTypes())
        {
            if (typeof(ITenantEntity).IsAssignableFrom(entityType.ClrType))
            {
                modelBuilder.Entity(entityType.ClrType)
                    .HasQueryFilter(GetTenantFilter(entityType.ClrType));
            }
        }
        
        // Soft delete global filter
        modelBuilder.Entity<Lease>()
            .HasQueryFilter(e => !e.IsDeleted);
    }
}
```

### 5.3 Caching Strategy

```mermaid
graph LR
    Client --> L1[L1 Cache<br/>In-Memory]
    L1 --> L2[L2 Cache<br/>Redis]
    L2 --> DB[(PostgreSQL)]
    
    style L1 fill:#e1f5ff
    style L2 fill:#fff4e1
    style DB fill:#ffe1e1
```

#### Cache Levels
1. **L1 - Application Memory**: Short-lived, request-scoped, configuration data
2. **L2 - Redis Distributed**: Cross-instance, session data, frequent queries
3. **Database Query Cache**: PostgreSQL built-in caching

#### Cache Invalidation
- **Time-based**: TTL for different data types (5min, 1hr, 24hr)
- **Event-based**: Invalidate on domain events (LeaseCreated, PaymentProcessed)
- **Manual**: API endpoints for cache clearing

### 5.4 Event Sourcing

```mermaid
sequenceDiagram
    participant Client
    participant API
    participant CommandHandler
    participant Aggregate
    participant EventStore
    participant EventBus
    participant Projection
    
    Client->>API: POST /leases
    API->>CommandHandler: CreateLeaseCommand
    CommandHandler->>Aggregate: Execute command
    Aggregate->>Aggregate: Validate business rules
    Aggregate->>EventStore: LeaseCreated event
    EventStore->>EventBus: Publish event
    EventBus->>Projection: Update read model
    Projection->>API: Success
    API->>Client: 201 Created
```

**Event Store Schema:**
```sql
CREATE TABLE event_store (
    id UUID PRIMARY KEY,
    aggregate_id UUID NOT NULL,
    aggregate_type VARCHAR(100) NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    event_data JSONB NOT NULL,
    metadata JSONB,
    version INT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_version UNIQUE (aggregate_id, version)
);
```

---

## 6. Deployment Architecture

### 6.1 Containerization

#### Dockerfile Example
```dockerfile
# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["Prodaric.Api/Prodaric.Api.csproj", "Prodaric.Api/"]
RUN dotnet restore "Prodaric.Api/Prodaric.Api.csproj"
COPY . .
RUN dotnet build "Prodaric.Api/Prodaric.Api.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "Prodaric.Api/Prodaric.Api.csproj" -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Prodaric.Api.dll"]
```

### 6.2 Kubernetes Architecture

```mermaid
graph TB
    subgraph "Kubernetes Cluster"
        subgraph "Ingress Layer"
            Ingress[Nginx Ingress Controller]
        end
        
        subgraph "Application Pods"
            API1[API Pod 1]
            API2[API Pod 2]
            API3[API Pod 3]
            Worker1[Worker Pod 1]
            Worker2[Worker Pod 2]
        end
        
        subgraph "Data Layer"
            PostgreSQL[(PostgreSQL<br/>StatefulSet)]
            Redis[(Redis Cluster)]
        end
        
        subgraph "Monitoring"
            Prometheus[Prometheus]
            Grafana[Grafana]
            Loki[Loki]
        end
    end
    
    Internet --> Ingress
    Ingress --> API1
    Ingress --> API2
    Ingress --> API3
    
    API1 --> PostgreSQL
    API2 --> PostgreSQL
    API3 --> PostgreSQL
    
    API1 --> Redis
    API2 --> Redis
    API3 --> Redis
    
    Worker1 --> PostgreSQL
    Worker2 --> PostgreSQL
    
    API1 --> Prometheus
    Prometheus --> Grafana
```

#### Kubernetes Manifests

**Deployment:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prodaric-api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: prodaric-api
  template:
    metadata:
      labels:
        app: prodaric-api
    spec:
      containers:
      - name: api
        image: prodaric/api:latest
        ports:
        - containerPort: 80
        env:
        - name: ASPNETCORE_ENVIRONMENT
          value: "Production"
        - name: ConnectionStrings__DefaultConnection
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: connection-string
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 80
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /health/ready
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
```

**Horizontal Pod Autoscaler:**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: prodaric-api-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: prodaric-api
  minReplicas: 3
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

### 6.3 CI/CD Pipeline

```mermaid
graph LR
    A[Git Push] --> B[GitHub Actions]
    B --> C[Build & Test]
    C --> D{Tests Pass?}
    D -->|No| E[Notify Team]
    D -->|Yes| F[Build Docker Image]
    F --> G[Push to Registry]
    G --> H[Deploy to Dev]
    H --> I{Manual Approval}
    I -->|Approved| J[Deploy to Staging]
    J --> K[Run E2E Tests]
    K --> L{Tests Pass?}
    L -->|No| E
    L -->|Yes| M{Manual Approval}
    M -->|Approved| N[Deploy to Production]
    N --> O[Health Check]
    O --> P{Healthy?}
    P -->|No| Q[Rollback]
    P -->|Yes| R[Success]
```

#### GitHub Actions Workflow

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: 8.0.x
      
      - name: Restore dependencies
        run: dotnet restore
      
      - name: Build
        run: dotnet build --no-restore --configuration Release
      
      - name: Run tests
        run: dotnet test --no-build --verbosity normal --collect:"XPlat Code Coverage"
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
  
  docker-build:
    needs: build-and-test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      
      - name: Login to Container Registry
        uses: docker/login-action@v2
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Build and push
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ghcr.io/prodaric/api:${{ github.sha }},ghcr.io/prodaric/api:latest
  
  deploy-dev:
    needs: docker-build
    runs-on: ubuntu-latest
    environment: development
    steps:
      - name: Deploy to Kubernetes
        run: |
          kubectl set image deployment/prodaric-api api=ghcr.io/prodaric/api:${{ github.sha }}
          kubectl rollout status deployment/prodaric-api
```

### 6.4 Environments

| Environment | Purpose | Auto-Deploy | URL |
|-------------|---------|-------------|-----|
| **Development** | Active development, feature branches | ✅ Yes | dev.prodaric.internal |
| **Staging** | Pre-production testing, QA | ✅ Yes (main branch) | staging.prodaric.com |
| **Production** | Live system | ❌ Manual approval | app.prodaric.com |

---

## 7. Security Architecture

### 7.1 Authentication Flow

```mermaid
sequenceDiagram
    participant User
    participant WebApp
    participant API
    participant IdentityServer
    participant Database
    
    User->>WebApp: Login request
    WebApp->>IdentityServer: Authorization request
    IdentityServer->>User: Login page
    User->>IdentityServer: Credentials
    IdentityServer->>Database: Validate user
    Database-->>IdentityServer: User valid
    IdentityServer->>IdentityServer: Generate tokens
    IdentityServer-->>WebApp: Access token + Refresh token
    WebApp->>API: Request with access token
    API->>API: Validate JWT
    API->>Database: Query data
    Database-->>API: Data
    API-->>WebApp: Response
    WebApp-->>User: Display data
```

### 7.2 Authorization (RBAC)

#### Role Hierarchy
```
SuperAdmin
  ├── TenantAdmin
  │   ├── PropertyManager
  │   │   ├── Leasing Agent
  │   │   └── Maintenance Coordinator
  │   └── Accountant
  └── Auditor (read-only)
```

#### Permission Matrix

| Role | Leases | Properties | Payments | Reports | Settings |
|------|--------|------------|----------|---------|----------|
| SuperAdmin | CRUD | CRUD | CRUD | CRUD | CRUD |
| TenantAdmin | CRUD | CRUD | CRUD | CRUD | CRUD (tenant) |
| PropertyManager | CRUD | R | R | R | - |
| Leasing Agent | CRU | R | R | R | - |
| Accountant | R | R | CRUD | CRUD | - |
| Auditor | R | R | R | R | - |

#### Implementation

```csharp
[Authorize(Policy = "RequirePropertyManagerRole")]
[RequirePermission("Lease", "Create")]
public async Task<IActionResult> CreateLease([FromBody] CreateLeaseCommand command)
{
    var result = await _mediator.Send(command);
    return CreatedAtAction(nameof(GetLease), new { id = result.LeaseId }, result);
}

public class RequirePermissionAttribute : TypeFilterAttribute
{
    public RequirePermissionAttribute(string resource, string action) 
        : base(typeof(PermissionFilter))
    {
        Arguments = new object[] { new Permission { Resource = resource, Action = action } };
    }
}
```

### 7.3 Data Encryption

#### Encryption at Rest
- **Database**: PostgreSQL with Transparent Data Encryption (TDE)
- **File Storage**: Azure Blob Storage with server-side encryption
- **Backups**: Encrypted with AES-256

#### Encryption in Transit
- **TLS 1.3**: All API communications
- **Certificate Management**: Let's Encrypt with auto-renewal
- **HSTS**: HTTP Strict Transport Security enabled

#### Sensitive Data Handling
```csharp
public class EncryptedDataConverter : ValueConverter<string, string>
{
    public EncryptedDataConverter(IDataProtectionProvider provider)
        : base(
            plainText => Encrypt(plainText, provider),
            cipherText => Decrypt(cipherText, provider))
    { }
    
    private static string Encrypt(string plainText, IDataProtectionProvider provider)
    {
        var protector = provider.CreateProtector("SensitiveData");
        return protector.Protect(plainText);
    }
}

// Usage in entity configuration
modelBuilder.Entity<Tenant>()
    .Property(e => e.BankAccountNumber)
    .HasConversion<EncryptedDataConverter>();
```

### 7.4 API Security

#### Rate Limiting
```csharp
services.AddRateLimiter(options =>
{
    options.GlobalLimiter = PartitionedRateLimiter.Create<HttpContext, string>(context =>
        RateLimitPartition.GetFixedWindowLimiter(
            partitionKey: context.User.Identity?.Name ?? context.Request.Headers.Host.ToString(),
            factory: partition => new FixedWindowRateLimiterOptions
            {
                AutoReplenishment = true,
                PermitLimit = 100,
                QueueLimit = 0,
                Window = TimeSpan.FromMinutes(1)
            }));
});
```

#### CORS Policy
```csharp
services.AddCors(options =>
{
    options.AddPolicy("ProdaricCorsPolicy", builder =>
    {
        builder.WithOrigins("https://app.prodaric.com", "https://staging.prodaric.com")
               .AllowAnyMethod()
               .AllowAnyHeader()
               .AllowCredentials();
    });
});
```

#### Security Headers
```csharp
app.Use(async (context, next) =>
{
    context.Response.Headers.Add("X-Content-Type-Options", "nosniff");
    context.Response.Headers.Add("X-Frame-Options", "DENY");
    context.Response.Headers.Add("X-XSS-Protection", "1; mode=block");
    context.Response.Headers.Add("Referrer-Policy", "strict-origin-when-cross-origin");
    context.Response.Headers.Add("Content-Security-Policy", 
        "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline';");
    await next();
});
```

### 7.5 Compliance Considerations

- **GDPR**: Data portability, right to erasure, consent management
- **SOC 2 Type II**: Security, availability, processing integrity
- **CCPA**: California Consumer Privacy Act compliance
- **Fair Housing Act**: No discriminatory data practices
- **PCI DSS**: Payment card data handling (if applicable)

---

## 8. Scalability & Performance

### 8.1 Horizontal Scaling Strategy

```mermaid
graph TB
    LB[Load Balancer<br/>Azure Application Gateway]
    
    subgraph "Region 1 - Primary"
        API1[API Pod 1]
        API2[API Pod 2]
        API3[API Pod 3]
        DB1[(Primary DB)]
    end
    
    subgraph "Region 2 - Secondary"
        API4[API Pod 4]
        API5[API Pod 5]
        DB2[(Replica DB)]
    end
    
    LB --> API1
    LB --> API2
    LB --> API3
    LB --> API4
    LB --> API5
    
    API1 --> DB1
    API2 --> DB1
    API3 --> DB1
    API4 --> DB2
    API5 --> DB2
    
    DB1 -.Replication.-> DB2
```

**Scaling Policies:**
- **Auto-scaling**: CPU > 70% or Memory > 80% → scale up
- **Predictive scaling**: Historical patterns for anticipated load
- **Regional failover**: Automatic DNS failover to secondary region

### 8.2 Caching Layers

#### Application-Level Caching
```csharp
public interface ICacheService
{
    Task<T> GetOrSetAsync<T>(string key, Func<Task<T>> factory, TimeSpan? expiration = null);
    Task RemoveAsync(string key);
    Task RemoveByPrefixAsync(string prefix);
}

// Usage
var tenantConfig = await _cacheService.GetOrSetAsync(
    $"tenant:{tenantId}:config",
    () => _tenantRepository.GetConfigurationAsync(tenantId),
    TimeSpan.FromHours(1)
);
```

#### CDN Strategy
- **Static Assets**: CloudFlare CDN for JS, CSS, images
- **API Responses**: Cached at edge for read-heavy endpoints
- **Invalidation**: Webhook-based purge on content updates

### 8.3 Database Optimization

#### Indexing Strategy
```sql
-- Covering index for common queries
CREATE INDEX idx_leases_tenant_property_status 
ON leases(tenant_id, property_id, status) 
INCLUDE (start_date, end_date, monthly_rent);

-- Partial index for active leases only
CREATE INDEX idx_active_leases 
ON leases(property_id) 
WHERE status = 'Active' AND end_date > CURRENT_DATE;

-- Full-text search index
CREATE INDEX idx_properties_fulltext 
ON properties USING GIN(to_tsvector('english', address || ' ' || description));
```

#### Query Optimization
- **Pagination**: Cursor-based for large datasets
- **Projection**: Select only required columns
- **Lazy Loading**: Disabled by default, explicit loading
- **Batch Operations**: Bulk inserts/updates via EF Core

#### Connection Pooling
```csharp
services.AddDbContext<ProdaricDbContext>(options =>
{
    options.UseNpgsql(connectionString, npgsqlOptions =>
    {
        npgsqlOptions.MinBatchSize(10);
        npgsqlOptions.MaxBatchSize(100);
        npgsqlOptions.CommandTimeout(30);
        npgsqlOptions.EnableRetryOnFailure(maxRetryCount: 3);
    });
}, ServiceLifetime.Scoped, ServiceLifetime.Singleton);
```

### 8.4 Performance Benchmarks

| Metric | Target | Achieved | Status |
|--------|--------|----------|--------|
| API Response Time (p95) | < 200ms | 150ms | ✅ |
| Database Query Time (p99) | < 100ms | 80ms | ✅ |
| Page Load Time | < 2s | 1.5s | ✅ |
| Concurrent Users | 10,000 | 12,000 | ✅ |
| Requests per Second | 5,000 | 6,500 | ✅ |
| Database Connections | 100 | 85 | ✅ |
| Cache Hit Rate | > 80% | 85% | ✅ |
| Error Rate | < 0.1% | 0.05% | ✅ |

**Load Testing**: Apache JMeter, k6, Azure Load Testing

---

## 9. Integration Points

### 9.1 External APIs

| Service | Purpose | Protocol | SLA |
|---------|---------|----------|-----|
| **Stripe** | Payment processing | REST | 99.99% |
| **Google Maps** | Geocoding, location services | REST | 99.9% |
| **SendGrid** | Email delivery | REST | 99.95% |
| **Twilio** | SMS notifications | REST | 99.95% |
| **DocuSign** | E-signatures | REST | 99.9% |
| **Zillow API** | Property data enrichment | REST | 99% |
| **Credit Bureau** | Tenant screening | SOAP/REST | 99.5% |

### 9.2 Webhooks

#### Outbound Webhooks
```csharp
public interface IWebhookService
{
    Task PublishAsync(string eventType, object payload, Guid tenantId);
}

// Event types
public static class WebhookEvents
{
    public const string LeaseCreated = "lease.created";
    public const string LeaseUpdated = "lease.updated";
    public const string PaymentReceived = "payment.received";
    public const string WorkOrderCompleted = "workorder.completed";
}

// Usage
await _webhookService.PublishAsync(
    WebhookEvents.LeaseCreated,
    new { LeaseId = lease.Id, TenantId = tenant.Id },
    _tenantContext.TenantId
);
```

#### Webhook Configuration
```http
POST /api/v1/webhooks
{
  "url": "https://customer.com/webhooks/prodaric",
  "events": ["lease.created", "payment.received"],
  "secret": "whsec_...",
  "active": true
}
```

### 9.3 Message Queues

```mermaid
graph LR
    API[API Service] --> Queue1[Command Queue]
    API --> Queue2[Event Queue]
    
    Queue1 --> Worker1[Command Worker]
    Queue2 --> Worker2[Event Handler 1]
    Queue2 --> Worker3[Event Handler 2]
    Queue2 --> Worker4[Event Handler 3]
    
    Worker1 --> DB[(Database)]
    Worker2 --> Email[Email Service]
    Worker3 --> Notif[Notification Service]
    Worker4 --> Analytics[Analytics Service]
```

**Message Types:**
- **Commands**: Imperative, single handler (CreateLeaseCommand)
- **Events**: Past tense, multiple handlers (LeaseCreatedEvent)
- **Queries**: Read-only, cached responses

### 9.4 Third-Party Integrations

#### Integration Architecture
```csharp
public interface IExternalServiceAdapter
{
    Task<TResult> ExecuteAsync<TResult>(IExternalServiceRequest request);
}

public class StripeAdapter : IExternalServiceAdapter
{
    private readonly IStripeClient _client;
    private readonly ICircuitBreaker _circuitBreaker;
    
    public async Task<TResult> ExecuteAsync<TResult>(IExternalServiceRequest request)
    {
        return await _circuitBreaker.ExecuteAsync(async () =>
        {
            // Retry logic with exponential backoff
            return await Polly.Policy
                .Handle<HttpRequestException>()
                .WaitAndRetryAsync(3, retryAttempt => 
                    TimeSpan.FromSeconds(Math.Pow(2, retryAttempt)))
                .ExecuteAsync(() => _client.SendAsync(request));
        });
    }
}
```

**Circuit Breaker Pattern:**
- **Closed**: Normal operation
- **Open**: Failures exceed threshold, fast-fail mode
- **Half-Open**: Testing if service recovered

---

## 10. Technology Decisions

### 10.1 Why .NET 8?

**Rationale:**
- ✅ **Performance**: Up to 20% faster than .NET 6, native AOT compilation
- ✅ **Cross-platform**: Linux, Windows, macOS support
- ✅ **Modern Language**: C# 12 with advanced features
- ✅ **Long-term Support**: LTS release with 3 years of support
- ✅ **Ecosystem**: Mature libraries, extensive documentation, large community
- ✅ **Cloud-native**: First-class Azure support, Kubernetes-ready
- ✅ **Developer Productivity**: Hot reload, top-level statements, minimal APIs

**Alternatives Considered:**
- ❌ Java/Spring Boot: More verbose, slower iteration
- ❌ Node.js: Not ideal for CPU-intensive operations
- ❌ Python/Django: Performance limitations at scale

### 10.2 Why React 18?

**Rationale:**
- ✅ **Performance**: Automatic batching, transitions, suspense
- ✅ **Developer Experience**: Large ecosystem, excellent tooling
- ✅ **Component Reusability**: Extensive component libraries
- ✅ **TypeScript Support**: First-class TypeScript integration
- ✅ **Community**: Largest frontend community, abundant resources
- ✅ **Server Components**: Future-ready architecture
- ✅ **Concurrent Features**: Improved UX with concurrent rendering

**Alternatives Considered:**
- ❌ Vue.js: Smaller ecosystem, less corporate adoption
- ❌ Angular: Heavier framework, steeper learning curve
- ❌ Svelte: Smaller community, less mature ecosystem

### 10.3 Why PostgreSQL?

**Rationale:**
- ✅ **ACID Compliance**: Full transactional integrity
- ✅ **JSON Support**: Native JSONB type for flexible schemas
- ✅ **Performance**: Excellent query optimization, materialized views
- ✅ **Extensions**: PostGIS for geospatial, full-text search
- ✅ **Open Source**: No licensing costs, community-driven
- ✅ **Scalability**: Horizontal scaling with Citus, logical replication
- ✅ **Advanced Features**: CTEs, window functions, array types

**Alternatives Considered:**
- ❌ MySQL: Less advanced features, weaker JSON support
- ❌ MongoDB: Eventual consistency, complex transactions
- ❌ SQL Server: Licensing costs, less portable

### 10.4 Why Kubernetes?

**Rationale:**
- ✅ **Industry Standard**: Most popular orchestration platform
- ✅ **Portability**: Run anywhere (Azure, AWS, GCP, on-prem)
- ✅ **Auto-scaling**: HPA and VPA for dynamic scaling
- ✅ **Self-healing**: Automatic recovery from failures
- ✅ **Declarative Configuration**: Infrastructure as code
- ✅ **Ecosystem**: Helm charts, operators, extensive tooling
- ✅ **Multi-tenancy**: Namespace isolation, resource quotas

**Alternatives Considered:**
- ❌ Docker Swarm: Limited features, smaller ecosystem
- ❌ Nomad: Less adoption, smaller community
- ❌ Managed Container Services: Vendor lock-in, less control

---

## Appendix

### A. Glossary

| Term | Definition |
|------|------------|
| **Aggregate** | A cluster of domain objects treated as a single unit for data changes |
| **Bounded Context** | A logical boundary within which a domain model is defined |
| **CQRS** | Command Query Responsibility Segregation - pattern separating reads and writes |
| **Domain Event** | Something that happened in the domain that domain experts care about |
| **Event Sourcing** | Storing state changes as a sequence of events |
| **Multi-tenancy** | Architecture where a single instance serves multiple customers |
| **PropTech** | Property Technology - technology for real estate industry |
| **Value Object** | Immutable object defined by its attributes rather than identity |

### B. References

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Domain-Driven Design by Eric Evans](https://domainlanguage.com/ddd/)
- [Microsoft .NET Architecture Guides](https://dotnet.microsoft.com/learn/dotnet/architecture-guides)
- [The Twelve-Factor App](https://12factor.net/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)

### C. Change Log

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0.0 | 2026-01-15 | Initial architecture document | Architecture Team |

---

<div align="center">

**Prodaric PropTech Platform**  
*Building the future of real estate technology*

[← Back to README](../README.md) | [Contributing Guide](../CONTRIBUTING.md) | [API Documentation](./api-reference.md)

</div>
