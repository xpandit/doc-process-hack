# Challenge 06: Personalized Loan & Insurance Offer Agent

**Expected Duration:** 90 minutes

---

## Introduction

Welcome to Challenge 06! In this challenge, you will build an intelligent AI Agent that taps into the structured loan application data (populated in Challenge 03) to generate personalized loan offers alongside tailored insurance recommendations. Imagine a digital assistant that not only assesses a customer’s loan application but also suggests the most suitable insurance product to protect their investment—whether it’s home insurance for a home loan or auto insurance for a vehicle loan.

This challenge introduces the concept of **AI Agents** and demonstrates how the [Semantic Kernel](https://github.com/microsoft/semantic-kernel) framework simplifies the creation of agentic AI systems. Semantic Kernel abstracts away much of the low-level implementation details so that developers can focus on crafting natural language prompts, chaining skills, and building modular agent workflows.

---

## Overview

In this challenge, your AI Agent will:

- **Retrieve Customer Data:** Pull loan application records from Cosmos DB (from Challenge 03) containing pivotal details such as loan purpose, loan amount, income, and employment status.
- **Segment and Analyze:** Evaluate the customer's financial profile with the aim of assessing their insurance needs.
- **Generate a Recommendation:** Cross-reference the customer’s profile with a pre-defined insurance product catalog to determine the optimal insurance product (for example, recommending Home Insurance for a customer applying for a home loan).
- **Produce Personalized Messaging:** Craft a natural language explanation that outlines the reasons behind the recommendation—including key financial metrics and customer-specific factors.
- **Leverage Semantic Kernel:** Use Semantic Kernel’s natural language orchestration abilities to streamline this complex reasoning process.

You can explore the full implementation in the [insurance_recomendation.ipynb](insurance_recomendation.ipynb) notebook.

---

## Architecture

1. **Data Retrieval:**  
   The agent fetches structured customer loan data from Cosmos DB—the same repository populated in Challenge 03. This data includes customer details, loan specifics, and employment information.

2. **Insurance Catalog:**  
   A simulated catalog of insurance products is provided, listing offerings such as Home Insurance, Auto Insurance, Credit Life Insurance, and Disability Insurance. This catalog serves as the reference for matching the customer’s profile with an appropriate product.

3. **Agent Logic using Semantic Kernel:**  
   Semantic Kernel simplifies the creation of the agent by handling prompt chaining and skill invocation. The agent uses kernels to reason over the customer’s data and the insurance catalog, generating recommendations with clear explanations.

4. **Output Generation:**  
   The final output is a structured recommendation, presented in a JSON-friendly format or as natural language, that details both the recommended insurance product and the rationale behind its selection.

---

## Prerequisites

Before you begin, please ensure you have:

- Completed Challenge 03 to populate your Cosmos DB with loan application data.
- An active Azure OpenAI service account with credentials (endpoint, API key, and model deployment such as GPT‑4o).
- Python (version 3.9 to 3.11) installed.
- Semantic Kernel for Python installed (run: `pip install semantic-kernel`).
- Properly configured environment variables:
  - `AZURE_OPENAI_ENDPOINT`
  - `AZURE_OPENAI_KEY`
  - `AZURE_OPENAI_MODEL` (e.g., "gpt-4o")
  - `COSMOS_ENDPOINT` and `COSMOS_KEY`
---

## How It Works

Your agent will first retrieve the pertinent loan data from Cosmos DB. It will then apply segmentation logic to evaluate aspects like loan purpose and customer income. With this information and the insurance catalog in hand, Semantic Kernel will power a series of skill invocations and prompt chains that generate a recommendation. The result will be a clear, personalized insurance offer message, explaining why the specific product best complements the customer's loan.

---

## Conclusion

Challenge 06 gives you the opportunity to extend the power of your previous work by building an agent that proactively recommends personalized insurance products alongside loan offers. By integrating your Cosmos DB data with Semantic Kernel's orchestration capabilities, you'll create an intelligent system that embodies true agentic AI—one that can autonomously analyze complex data, reason through customer needs, and deliver actionable, personalized insights.