# Tax Calculator (by @dotconde)

A Ruby-based tax calculation system for Munchitos S.A. that handles VAT calculations across EU and non-EU countries.

## Overview

This system calculates taxes for:
- Physical products (food items)
- Digital subscription services
- In-person training courses

Tax calculations are based on:
- Buyer's location (Spain/EU/non-EU)
- Buyer's status (individual/company)
- Service type (physical/digital/onsite)
- Service location (for onsite services)

## Requirements

- Ruby 3.2
- Docker

## Setup

1. Clone the repository:
```bash
git clone https://github.com/dotconde/quaderno_tax
cd quaderno_tax
```

2. Build the Docker image:
```bash
docker build -t tax-calculator .
```

## Running Tests
```bash
docker run tax-calculator
```
