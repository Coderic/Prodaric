# Contributing to Prodaric

> **Welcome!** 👋 We're thrilled that you're interested in contributing to Prodaric. This document will help you get started.

First off, thank you for considering contributing to Prodaric. It's people like you that make Prodaric such a great platform for the PropTech community.

---

## 🌟 Our Values

Prodaric is built on these core principles:

- **🤝 Collaboration**: We believe great software is built together
- **🎯 Quality**: We value well-tested, maintainable code over quick hacks
- **📚 Knowledge Sharing**: We document everything and help each other learn
- **🌍 Inclusivity**: Everyone is welcome, regardless of experience level
- **🚀 Innovation**: We embrace new ideas and technologies
- **💬 Transparency**: We develop in the open and communicate clearly

### Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [neftali@coderic.org](mailto:neftali@coderic.org).

---

## 🎯 Ways to Contribute

You don't need to be a developer to contribute! Here are many ways you can help:

### 💻 Code Contributions
- Implement new features
- Fix bugs
- Improve performance
- Refactor code
- Add tests

### 📖 Documentation
- Improve existing docs
- Write tutorials
- Create video guides
- Fix typos
- Translate documentation

### 🐛 Bug Reports
- Report bugs you encounter
- Verify existing bug reports
- Provide reproduction steps
- Test bug fixes

### 💡 Feature Requests
- Suggest new features
- Discuss feature proposals
- Vote on features
- Provide use cases

### 💬 Community Support
- Answer questions in discussions
- Help other contributors
- Review pull requests
- Share your Prodaric projects

### 🌍 Translations
- Translate UI strings
- Localize documentation
- Maintain language packs
- Review translations

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Git** - [Download](https://git-scm.com/downloads)
- **.NET 8 SDK** - [Download](https://dotnet.microsoft.com/download/dotnet/8.0)
- **Node.js 20+** - [Download](https://nodejs.org/)
- **PostgreSQL 15+** - [Download](https://www.postgresql.org/download/)
- **Docker** (optional) - [Download](https://www.docker.com/get-started)
- **Visual Studio 2022** or **VS Code** - Your choice!

### 1. Fork the Repository

Click the "Fork" button at the top right of the repository page to create your own copy.

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR_USERNAME/REPOSITORY_NAME.git
cd REPOSITORY_NAME

# Add upstream remote
git remote add upstream https://github.com/prodaric/REPOSITORY_NAME.git
```

### 3. Set Up Development Environment

#### Backend Setup (.NET)

```bash
cd src/backend

# Restore dependencies
dotnet restore

# Set up database
dotnet ef database update

# Run the application
dotnet run --project Prodaric.Api
```

The API will be available at `https://localhost:5001`

#### Frontend Setup (React)

```bash
cd src/frontend

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env.local

# Run development server
npm run dev
```

The web app will be available at `http://localhost:3000`

#### Using Docker (Recommended)

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### 4. Create a Branch

```bash
# Get latest changes from upstream
git checkout main
git pull upstream main

# Create your feature branch
git checkout -b feature/your-feature-name
```

### 5. Make Your Changes

Write your code, following our [coding standards](#-coding-standards)!

### 6. Run Tests

```bash
# Backend tests
cd src/backend
dotnet test

# Frontend tests
cd src/frontend
npm test

# E2E tests
npm run test:e2e
```

### 7. Commit Your Changes

Follow [Conventional Commits](https://www.conventionalcommits.org/) format:

```bash
git add .
git commit -m "feat: add property search functionality"
```

### 8. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 9. Create a Pull Request

Go to the original repository and click "New Pull Request". Fill out the PR template with all the details!

---

## 🔄 Development Workflow

### Branch Naming Conventions

Follow these naming patterns for your branches:

| Type | Pattern | Example |
|------|---------|---------|
| **Feature** | `feature/description` | `feature/add-lease-export` |
| **Bug Fix** | `bugfix/issue-number-description` | `bugfix/123-fix-payment-calculation` |
| **Hotfix** | `hotfix/description` | `hotfix/security-vulnerability` |
| **Documentation** | `docs/description` | `docs/update-api-reference` |
| **Refactor** | `refactor/description` | `refactor/simplify-auth-service` |
| **Test** | `test/description` | `test/add-lease-integration-tests` |

### Commit Message Format

We use [Conventional Commits](https://www.conventionalcommits.org/) for clear, semantic commit messages:

```
<type>(<scope>): <subject>

<body>

<footer>
```

#### Type

| Type | Description | Example |
|------|-------------|---------|
| `feat` | New feature | `feat(lease): add rent reminder notifications` |
| `fix` | Bug fix | `fix(api): correct payment calculation rounding` |
| `docs` | Documentation | `docs(readme): update installation instructions` |
| `style` | Code style (formatting) | `style(api): format with prettier` |
| `refactor` | Code refactoring | `refactor(auth): simplify token validation` |
| `test` | Adding tests | `test(lease): add unit tests for renewal logic` |
| `chore` | Maintenance | `chore(deps): update dependencies` |
| `perf` | Performance improvement | `perf(db): optimize lease query indexes` |
| `ci` | CI/CD changes | `ci(github): add automated deployment` |
| `build` | Build system changes | `build(docker): update base image` |

#### Examples

**Good commits:**

```bash
feat(lease): add bulk lease creation endpoint

Implements POST /api/v1/leases/bulk to create multiple leases
in a single request. Includes validation, transaction handling,
and error reporting.

Closes #123
```

```bash
fix(api): prevent duplicate payment processing

Adds idempotency key validation to prevent duplicate charges
when users submit payment multiple times.

Fixes #456
```

**Bad commits:**

```bash
# Too vague
git commit -m "fix bug"

# Not following convention
git commit -m "Fixed the thing that was broken"

# Missing scope
git commit -m "feat: new feature"
```

### Pull Request Process

#### Before Creating a PR

- [ ] Code follows our coding standards
- [ ] Tests are passing (`dotnet test`, `npm test`)
- [ ] Code coverage maintained or improved
- [ ] Documentation updated (if needed)
- [ ] Changelog entry added
- [ ] Branch is up to date with `main`

#### PR Title Format

Use the same format as commit messages:

```
feat(lease): add bulk lease creation endpoint
```

#### PR Description Template

When you create a PR, fill out this template:

```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Related Issues
Closes #123
Related to #456

## Changes Made
- Added bulk lease creation endpoint
- Implemented validation logic
- Added integration tests
- Updated API documentation

## Testing
Describe how you tested these changes:
- Unit tests added for validation logic
- Integration tests for API endpoint
- Manual testing with 100 lease batch

## Screenshots (if applicable)
Add screenshots of UI changes

## Checklist
- [ ] Tests pass locally
- [ ] Code follows style guidelines
- [ ] Self-reviewed the code
- [ ] Commented complex logic
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Added tests that prove fix/feature works
- [ ] New/existing tests pass locally
- [ ] Dependent changes merged
```

#### Code Review Expectations

**As a Contributor:**
- Be open to feedback and suggestions
- Respond to review comments promptly
- Make requested changes or explain why not
- Be respectful and professional

**As a Reviewer:**
- Review within 48 hours when possible
- Be constructive and specific
- Praise good solutions
- Explain the "why" behind suggestions
- Approve when ready, request changes when needed

#### Review Checklist for Maintainers

- [ ] Code follows project conventions
- [ ] Appropriate tests included
- [ ] Documentation updated
- [ ] No obvious bugs or security issues
- [ ] Performance considerations addressed
- [ ] Breaking changes clearly documented
- [ ] Changelog updated

### Merge Strategy

We use **Squash and Merge** for most PRs:
- Keeps git history clean
- All commits from PR squashed into one
- Commit message follows conventional commits

**Exceptions:**
- Large features may use **Merge Commit**
- Hotfixes may use **Rebase and Merge**

---

## 📝 Coding Standards

### C# Backend Standards

#### Naming Conventions

```csharp
// PascalCase for classes, methods, properties
public class LeaseService { }
public void CreateLease() { }
public string PropertyName { get; set; }

// camelCase for private fields (with _)
private readonly ILeaseRepository _leaseRepository;

// camelCase for parameters and local variables
public void ProcessPayment(decimal amount, string description)
{
    var processedDate = DateTime.UtcNow;
}

// UPPER_CASE for constants
public const string DEFAULT_CURRENCY = "USD";
```

#### Code Organization

```csharp
// File structure
namespace Prodaric.Lease.Application.Commands;

// Usings at top
using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;

// One class per file
public class CreateLeaseCommand : IRequest<CreateLeaseResult>
{
    // Properties first
    public Guid PropertyId { get; init; }
    public Guid TenantId { get; init; }
    public decimal MonthlyRent { get; init; }
    
    // Constructor
    public CreateLeaseCommand(Guid propertyId, Guid tenantId, decimal monthlyRent)
    {
        PropertyId = propertyId;
        TenantId = tenantId;
        MonthlyRent = monthlyRent;
    }
    
    // Methods
    public void Validate()
    {
        // Validation logic
    }
}
```

#### SOLID Principles

**Single Responsibility:**
```csharp
// Good - Single responsibility
public class LeaseValidator
{
    public ValidationResult Validate(Lease lease) { }
}

public class LeaseNotifier
{
    public Task NotifyTenantAsync(Lease lease) { }
}

// Bad - Multiple responsibilities
public class LeaseService
{
    public ValidationResult ValidateLease(Lease lease) { }
    public Task NotifyTenant(Lease lease) { }
    public Task SaveToDatabase(Lease lease) { }
}
```

**Dependency Inversion:**
```csharp
// Good - Depend on abstraction
public class LeaseService
{
    private readonly ILeaseRepository _repository;
    
    public LeaseService(ILeaseRepository repository)
    {
        _repository = repository;
    }
}

// Bad - Depend on concrete implementation
public class LeaseService
{
    private readonly LeaseRepository _repository = new();
}
```

#### Async/Await Best Practices

```csharp
// Good
public async Task<Lease> CreateLeaseAsync(CreateLeaseCommand command)
{
    var lease = new Lease(command);
    await _repository.AddAsync(lease);
    await _unitOfWork.CommitAsync();
    return lease;
}

// Bad - Blocking
public Lease CreateLease(CreateLeaseCommand command)
{
    var lease = new Lease(command);
    _repository.AddAsync(lease).Wait(); // Don't do this!
    return lease;
}
```

#### Error Handling

```csharp
// Good - Specific exceptions
public async Task<Lease> GetLeaseAsync(Guid id)
{
    var lease = await _repository.FindByIdAsync(id);
    
    if (lease == null)
        throw new LeaseNotFoundException(id);
    
    if (lease.IsDeleted)
        throw new LeaseAlreadyDeletedException(id);
    
    return lease;
}

// Use Result pattern for expected failures
public async Task<Result<Lease>> CreateLeaseAsync(CreateLeaseCommand command)
{
    var validation = _validator.Validate(command);
    if (!validation.IsValid)
        return Result<Lease>.Failure(validation.Errors);
    
    var lease = new Lease(command);
    await _repository.AddAsync(lease);
    
    return Result<Lease>.Success(lease);
}
```

### React/TypeScript Frontend Standards

#### Component Structure

```typescript
// Good - Functional component with TypeScript
import React, { useState, useEffect } from 'react';
import { Lease } from '@/types';
import { fetchLeases } from '@/api/leaseApi';

interface LeaseListProps {
  propertyId: string;
  onSelect: (lease: Lease) => void;
}

export const LeaseList: React.FC<LeaseListProps> = ({ propertyId, onSelect }) => {
  const [leases, setLeases] = useState<Lease[]>([]);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    const loadLeases = async () => {
      try {
        const data = await fetchLeases(propertyId);
        setLeases(data);
      } catch (error) {
        console.error('Failed to load leases:', error);
      } finally {
        setLoading(false);
      }
    };
    
    loadLeases();
  }, [propertyId]);
  
  if (loading) return <LoadingSpinner />;
  
  return (
    <div className="lease-list">
      {leases.map(lease => (
        <LeaseCard 
          key={lease.id} 
          lease={lease} 
          onClick={() => onSelect(lease)} 
        />
      ))}
    </div>
  );
};
```

#### Type Safety

```typescript
// Good - Strong typing
interface CreateLeaseRequest {
  propertyId: string;
  tenantId: string;
  startDate: Date;
  endDate: Date;
  monthlyRent: number;
}

const createLease = async (request: CreateLeaseRequest): Promise<Lease> => {
  const response = await api.post<Lease>('/api/v1/leases', request);
  return response.data;
};

// Bad - Using 'any'
const createLease = async (data: any): Promise<any> => {
  return await api.post('/api/v1/leases', data);
};
```

#### Hooks Best Practices

```typescript
// Good - Custom hook
export const useLeases = (propertyId: string) => {
  const [leases, setLeases] = useState<Lease[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);
  
  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const data = await fetchLeases(propertyId);
        setLeases(data);
      } catch (err) {
        setError(err as Error);
      } finally {
        setLoading(false);
      }
    };
    
    fetchData();
  }, [propertyId]);
  
  return { leases, loading, error };
};

// Usage
const LeaseComponent = ({ propertyId }: Props) => {
  const { leases, loading, error } = useLeases(propertyId);
  
  // Component logic
};
```

### General Clean Code Principles

#### Meaningful Names

```csharp
// Good
public class LeasePaymentProcessor { }
public decimal CalculateMonthlyRent(Lease lease) { }
private bool IsLeaseActive(Lease lease) { }

// Bad
public class LPP { }
public decimal Calc(Lease l) { }
private bool Check(Lease x) { }
```

#### Small Functions

```csharp
// Good - Single responsibility, easy to understand
public async Task<Lease> CreateLeaseAsync(CreateLeaseCommand command)
{
    ValidateCommand(command);
    var lease = BuildLease(command);
    await PersistLeaseAsync(lease);
    await NotifyStakeholdersAsync(lease);
    return lease;
}

// Bad - Too long, does too much
public async Task<Lease> CreateLeaseAsync(CreateLeaseCommand command)
{
    // 200 lines of code doing everything
}
```

#### Comments

```csharp
// Good - Explain WHY, not WHAT
// We use UTC timestamps to ensure consistency across time zones
// when calculating lease durations and payment schedules
private DateTime ConvertToUtc(DateTime localTime)
{
    return TimeZoneInfo.ConvertTimeToUtc(localTime);
}

// Bad - States the obvious
// This method converts to UTC
private DateTime ConvertToUtc(DateTime localTime)
{
    return TimeZoneInfo.ConvertTimeToUtc(localTime);
}

// Good - Complex business logic needs explanation
// Fair Housing Act compliance: Never use protected characteristics
// (race, religion, national origin, etc.) in tenant scoring.
// We only consider verifiable financial and rental history.
public decimal CalculateTenantScore(TenantApplication application)
{
    // Implementation
}
```

---

## 🧪 Testing Requirements

### Test Coverage Requirements

- **Minimum Coverage**: 80% overall
- **New Features**: 90% coverage required
- **Critical Paths**: 100% coverage (payments, authentication, data integrity)

### Unit Tests

Test individual components in isolation:

```csharp
public class LeaseServiceTests
{
    [Fact]
    public async Task CreateLease_WithValidData_ShouldSucceed()
    {
        // Arrange
        var repository = new Mock<ILeaseRepository>();
        var service = new LeaseService(repository.Object);
        var command = new CreateLeaseCommand
        {
            PropertyId = Guid.NewGuid(),
            TenantId = Guid.NewGuid(),
            MonthlyRent = 1000
        };
        
        // Act
        var result = await service.CreateLeaseAsync(command);
        
        // Assert
        result.Should().NotBeNull();
        result.MonthlyRent.Should().Be(1000);
        repository.Verify(r => r.AddAsync(It.IsAny<Lease>()), Times.Once);
    }
    
    [Fact]
    public async Task CreateLease_WithInvalidRent_ShouldThrowException()
    {
        // Arrange
        var service = new LeaseService(Mock.Of<ILeaseRepository>());
        var command = new CreateLeaseCommand { MonthlyRent = -100 };
        
        // Act & Assert
        await Assert.ThrowsAsync<ValidationException>(
            () => service.CreateLeaseAsync(command)
        );
    }
}
```

### Integration Tests

Test multiple components together:

```csharp
public class LeaseApiIntegrationTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;
    
    public LeaseApiIntegrationTests(WebApplicationFactory<Program> factory)
    {
        _client = factory.CreateClient();
    }
    
    [Fact]
    public async Task POST_CreateLease_ReturnsCreatedLease()
    {
        // Arrange
        var request = new CreateLeaseRequest
        {
            PropertyId = TestData.PropertyId,
            TenantId = TestData.TenantId,
            MonthlyRent = 1500
        };
        
        // Act
        var response = await _client.PostAsJsonAsync("/api/v1/leases", request);
        
        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Created);
        var lease = await response.Content.ReadFromJsonAsync<LeaseDto>();
        lease.MonthlyRent.Should().Be(1500);
    }
}
```

### E2E Tests

Test complete user workflows:

```typescript
// Playwright/Cypress example
describe('Lease Creation Flow', () => {
  it('should create a new lease successfully', () => {
    // Login
    cy.visit('/login');
    cy.get('[data-testid="email"]').type('test@example.com');
    cy.get('[data-testid="password"]').type('password123');
    cy.get('[data-testid="login-button"]').click();
    
    // Navigate to leases
    cy.url().should('include', '/dashboard');
    cy.get('[data-testid="leases-menu"]').click();
    
    // Create lease
    cy.get('[data-testid="new-lease-button"]').click();
    cy.get('[data-testid="property-select"]').select('Property 1');
    cy.get('[data-testid="tenant-select"]').select('John Doe');
    cy.get('[data-testid="monthly-rent"]').type('1500');
    cy.get('[data-testid="submit-button"]').click();
    
    // Verify
    cy.get('[data-testid="success-message"]').should('be.visible');
    cy.get('[data-testid="lease-list"]').should('contain', 'John Doe');
  });
});
```

### Running Tests

```bash
# Backend
cd src/backend

# Run all tests
dotnet test

# Run with coverage
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover

# Run specific test
dotnet test --filter "FullyQualifiedName~LeaseServiceTests"

# Frontend
cd src/frontend

# Run all tests
npm test

# Run with coverage
npm test -- --coverage

# Run E2E tests
npm run test:e2e

# Run specific test file
npm test -- LeaseForm.test.tsx
```

---

## 📚 Documentation Standards

### Code Comments

#### XML Documentation (C#)

```csharp
/// <summary>
/// Creates a new lease agreement for a property.
/// </summary>
/// <param name="command">The lease creation command containing property and tenant details.</param>
/// <returns>The created lease with generated ID and timestamps.</returns>
/// <exception cref="ValidationException">Thrown when command validation fails.</exception>
/// <exception cref="PropertyNotFoundException">Thrown when property doesn't exist.</exception>
/// <exception cref="TenantNotFoundException">Thrown when tenant doesn't exist.</exception>
/// <remarks>
/// This method validates the command, checks property availability,
/// verifies tenant eligibility, and creates the lease in a transaction.
/// Stakeholders are notified via email after successful creation.
/// </remarks>
public async Task<Lease> CreateLeaseAsync(CreateLeaseCommand command)
{
    // Implementation
}
```

#### JSDoc (TypeScript)

```typescript
/**
 * Fetches all leases for a specific property
 * @param propertyId - The unique identifier of the property
 * @param options - Optional query parameters for filtering and pagination
 * @returns Promise resolving to array of leases
 * @throws {ApiError} When the API request fails
 * @example
 * ```typescript
 * const leases = await fetchLeases('property-123', { 
 *   status: 'active',
 *   limit: 10 
 * });
 * ```
 */
export async function fetchLeases(
  propertyId: string,
  options?: LeaseQueryOptions
): Promise<Lease[]> {
  // Implementation
}
```

### README Updates

When adding a new feature or module, update the relevant README:

- Describe what the feature does
- Show usage examples
- Document configuration options
- Link to detailed documentation

### Changelog Entries

Add an entry to `CHANGELOG.md` following [Keep a Changelog](https://keepachangelog.com/):

```markdown
## [Unreleased]

### Added
- Bulk lease creation endpoint ([#123](https://github.com/prodaric/Prodaric/pull/123))
- Export leases to CSV functionality ([#124](https://github.com/prodaric/Prodaric/pull/124))

### Fixed
- Payment calculation rounding error ([#125](https://github.com/prodaric/Prodaric/pull/125))

### Changed
- Improved lease validation logic ([#126](https://github.com/prodaric/Prodaric/pull/126))
```

---

## ✅ Pull Request Checklist

Before submitting your PR, verify:

### Code Quality
- [ ] Code follows project coding standards
- [ ] No linting errors (`dotnet format`, `npm run lint`)
- [ ] All variables and functions have meaningful names
- [ ] Complex logic is commented
- [ ] No commented-out code (remove or explain why it's there)
- [ ] No console.log or debug code left in

### Testing
- [ ] All tests pass locally
- [ ] New tests added for new functionality
- [ ] Edge cases covered
- [ ] Test coverage maintained or improved (> 80%)
- [ ] Integration tests added for API changes
- [ ] E2E tests updated if UI changed

### Documentation
- [ ] XML docs added for public APIs (C#)
- [ ] JSDoc added for exported functions (TypeScript)
- [ ] README updated if needed
- [ ] API documentation updated
- [ ] Changelog entry added
- [ ] Migration guide added (for breaking changes)

### Security & Performance
- [ ] No security vulnerabilities introduced
- [ ] Input validation implemented
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (proper escaping)
- [ ] Performance impact considered
- [ ] Database queries optimized
- [ ] No N+1 query problems

### Git
- [ ] Branch is up to date with `main`
- [ ] Commits follow conventional commits format
- [ ] Commit history is clean (consider squashing)
- [ ] No merge conflicts

### PR Description
- [ ] Clear description of changes
- [ ] Links to related issues
- [ ] Screenshots added (for UI changes)
- [ ] Breaking changes clearly marked
- [ ] Migration instructions provided (if needed)

---

## 🏆 Recognition & Community

### Contributor Recognition

We value every contribution! Contributors are recognized in:

- **README.md**: Contributors section
- **Release Notes**: Credit for significant contributions
- **Social Media**: Shoutouts for notable features
- **Contributor Badges**: GitHub profile badges
- **Annual Report**: Top contributors highlighted

### Community Channels

Stay connected with the Prodaric community:

| Channel | Purpose | Link |
|---------|---------|------|
| 💬 **GitHub Discussions** | Q&A, feature discussions, show & tell | [Join](https://github.com/orgs/prodaric/discussions) |
| 🐛 **Issues** | Bug reports, feature requests | [View](https://github.com/prodaric/Prodaric/issues) |
| 📧 **Email** | Direct questions to maintainers | [neftali@coderic.org](mailto:neftali@coderic.org) |
| 🐦 **Twitter** | Updates and announcements | [@prodaric](https://twitter.com/prodaric) (coming soon) |

### Office Hours

Maintainers host office hours for contributors:

- **When**: Every other Wednesday, 2:00 PM UTC
- **Where**: GitHub Discussions (pinned post)
- **Topics**: Architecture discussions, contribution help, roadmap planning

### First-Time Contributors

Looking for a good first issue? Check out:

- [`good-first-issue`](https://github.com/prodaric/Prodaric/labels/good-first-issue) label
- [`help-wanted`](https://github.com/prodaric/Prodaric/labels/help-wanted) label
- [`documentation`](https://github.com/prodaric/Prodaric/labels/documentation) label

**Pro Tip**: Comment on an issue to let others know you're working on it!

### Mentorship Program

New to open source? We offer mentorship:

- Pair programming sessions
- Code review guidance
- Architecture discussions
- Career advice

Contact us at [neftali@coderic.org](mailto:neftali@coderic.org) to get paired with a mentor.

---

## 📄 License

By contributing to Prodaric, you agree that your contributions will be licensed under the [MIT License](LICENSE).

### Contributor License Agreement (CLA)

Currently, we **do not require** a CLA. Your pull request implies you have the right to license your code under MIT and you grant us that license.

We may introduce a CLA in the future if needed for legal clarity, with advance notice to the community.

### Copyright

- You retain copyright of your contributions
- You grant Prodaric a license to use your contributions
- Your name/handle will be included in the contributors list

---

## 🤔 Questions?

### Frequently Asked Questions

**Q: How long does it take to get a PR reviewed?**  
A: We aim to review PRs within 48 hours. Complex PRs may take longer.

**Q: Can I work on multiple issues at once?**  
A: We recommend focusing on one issue at a time, especially if you're new.

**Q: What if my PR is rejected?**  
A: We'll explain why and suggest improvements. Rejection is rare and usually due to misalignment with project goals.

**Q: Can I contribute without coding?**  
A: Absolutely! Documentation, bug reports, testing, and community support are all valuable.

**Q: Do I need to sign a CLA?**  
A: Not currently. This may change in the future with advance notice.

**Q: How do I become a maintainer?**  
A: Active contributors with consistent high-quality contributions may be invited to become maintainers.

### Getting Help

Stuck? Need help? Reach out:

1. **Search Existing Issues**: Someone may have had the same question
2. **GitHub Discussions**: Ask in the Q&A category
3. **Discord/Slack**: Real-time help from the community (coming soon)
4. **Email Maintainers**: [neftali@coderic.org](mailto:neftali@coderic.org)

### Contact Maintainers

| Name | Role | GitHub | Email |
|------|------|--------|-------|
| Neftalí Yagua | Lead Maintainer | [@neftaliyagua](https://github.com/neftaliyagua) | neftali@coderic.org |

---

## 🙏 Thank You

Thank you for contributing to Prodaric! Every contribution, no matter how small, makes a difference. Together, we're building the future of PropTech.

**Happy coding! 🚀**

---

<div align="center">

[← Back to README](README.md) | [Code of Conduct](CODE_OF_CONDUCT.md) | [Roadmap](ROADMAP.md) | [Architecture](docs/ARCHITECTURE.md)

---

*Made with ❤️ by the Prodaric community*

</div>
