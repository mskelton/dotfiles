# Development Guidelines for Claude

## General

- After receiving tool results, carefully reflect on their quality and determine
  optimal next steps before proceeding. Use your thinking to plan and iterate
  based on this new information, and then take the best next action.
- For maximum efficiency, whenever you need to perform multiple independent
  operations, invoke all relevant tools simultaneously using sub agents rather
  than sequentially.

## No Comments in Code

Code should be self-documenting through clear naming and structure. Comments
indicate that the code itself is not clear enough.

```typescript
// Avoid: Comments explaining what the code does
const calculateDiscount = (price: number, customer: Customer): number => {
  // Check if customer is premium
  if (customer.tier === "premium") {
    // Apply 20% discount for premium customers
    return price * 0.8
  }
  // Regular customers get 10% discount
  return price * 0.9
}

// Good: Self-documenting code with clear names
const PREMIUM_DISCOUNT_MULTIPLIER = 0.8
const STANDARD_DISCOUNT_MULTIPLIER = 0.9

const isPremiumCustomer = (customer: Customer): boolean => {
  return customer.tier === "premium"
}

const calculateDiscount = (price: number, customer: Customer): number => {
  const discountMultiplier = isPremiumCustomer(customer)
    ? PREMIUM_DISCOUNT_MULTIPLIER
    : STANDARD_DISCOUNT_MULTIPLIER

  return price * discountMultiplier
}

// Avoid: Complex logic with comments
const processPayment = (payment: Payment): ProcessedPayment => {
  // First validate the payment
  if (!validatePayment(payment)) {
    throw new Error("Invalid payment")
  }

  // Check if we need to apply 3D secure
  if (payment.amount > 100 && payment.card.type === "credit") {
    // Apply 3D secure for credit cards over £100
    const securePayment = apply3DSecure(payment)
    // Process the secure payment
    return executePayment(securePayment)
  }

  // Process the payment
  return executePayment(payment)
}

// Good: Extract to well-named functions
const requires3DSecure = (payment: Payment): boolean => {
  const SECURE_PAYMENT_THRESHOLD = 100
  return (
    payment.amount > SECURE_PAYMENT_THRESHOLD && payment.card.type === "credit"
  )
}

const processPayment = (payment: Payment): ProcessedPayment => {
  if (!validatePayment(payment)) {
    throw new PaymentValidationError("Invalid payment")
  }

  const securedPayment = requires3DSecure(payment)
    ? apply3DSecure(payment)
    : payment

  return executePayment(securedPayment)
}
```

Exception: JSDoc comments for public APIs are acceptable when generating
documentation, but the code should still be self-explanatory without them.

## Commit Guidelines

- Each commit should represent a complete, working change
- Use conventional commits format:
  ```
  feat: add payment validation
  fix: correct date formatting in payment processor
  refactor: extract payment validation logic
  test: add edge cases for payment validation
  ```

## Pull Request Standards

- Every pull request must have all tests passing
- All linting and quality checks must pass
- Work in small increments that maintain a working state
- Pull requests should be focused on a single feature or fix
- Include description of the behavior change, not implementation details
