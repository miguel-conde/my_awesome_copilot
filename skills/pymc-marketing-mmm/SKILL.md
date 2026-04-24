---
name: pymc-marketing-mmm
description: Implement Marketing Mix Models (MMM) using the pymc-marketing Bayesian library. Covers model setup, adstock/saturation transformations, fitting, diagnostics, budget allocation, lift test calibration, causal inference, and model evaluation. Use when building or improving MMM models with pymc-marketing, navigating pymc-marketing documentation, choosing the right MMM notebook or API reference, or answering any pymc-marketing MMM implementation question. Combine with the pymc-modeling skill for advanced Bayesian modeling questions.
---

# MMM with PyMC-Marketing

Implement Marketing Mix Models (MMM) end-to-end using the `pymc-marketing` Bayesian library.

## When to Use This Skill

Load this skill when:

- User is implementing, debugging, or extending an MMM with pymc-marketing
- User asks about adstock, saturation, channel contributions, ROAS, or budget allocation in a pymc-marketing context
- User needs to navigate pymc-marketing documentation to find the right example or API reference
- User is calibrating an MMM with lift tests or applying causal inference techniques
- Any pymc-marketing MMM question arises

> **If available, combine with `pymc-modeling` skill** for advanced Bayesian modeling, prior selection, or MCMC diagnostics questions.

---

## Step 1: Clarify the Task

Identify which MMM sub-task the user needs before diving in:

| User goal | Where to go |
|---|---|
| Getting started / first model | Step 2 → MMM Quickstart, then Step 3 |
| Adstock or saturation technique | Step 2 → find notebook, then Step 3 |
| Budget optimization | [Budget Allocation notebook](https://www.pymc-marketing.io/en/stable/notebooks/mmm/mmm_budget_allocation_example.html) |
| Risk-aware budget planning | [Budget + Risk Assessment](https://www.pymc-marketing.io/en/stable/notebooks/mmm/mmm_allocation_assessment.html) |
| Lift test calibration | [Lift Test notebook](https://www.pymc-marketing.io/en/stable/notebooks/mmm/mmm_lift_test.html) |
| Model evaluation / cross-validation | [Evaluation notebook](https://www.pymc-marketing.io/en/stable/notebooks/mmm/mmm_evaluation.html) |
| Causal inference / counterfactuals | [Causal Identification notebook](https://www.pymc-marketing.io/en/stable/notebooks/mmm/mmm_causal_identification.html) |
| Geo-level / multidimensional MMM | [Geo-MMM notebook](https://www.pymc-marketing.io/en/stable/notebooks/mmm/mmm_multidimensional_example.html) |
| Time-varying effects | [TVP notebook](https://www.pymc-marketing.io/en/stable/notebooks/mmm/mmm_tvp_example.html) |
| Custom model architecture | [MMM Components](https://www.pymc-marketing.io/en/stable/notebooks/mmm/mmm_components.html) |
| End-to-end example | [Case Study](https://www.pymc-marketing.io/en/stable/notebooks/mmm/mmm_case_study.html) |

---

## Step 2: Navigate Documentation

Use these canonical references. **Always fetch the relevant page** to provide up-to-date code and API usage — pymc-marketing evolves rapidly (currently v0.19.3).

### Primary Entry Points

| Resource | URL |
|---|---|
| Installation | https://www.pymc-marketing.io/en/stable/getting_started/installation/index.html |
| MMM Quickstart | https://www.pymc-marketing.io/en/stable/getting_started/quickstart/mmm/index.html |
| Full Example Gallery | https://www.pymc-marketing.io/en/stable/gallery/gallery.html |
| API Reference | https://www.pymc-marketing.io/en/stable/api/index.html |

### Task-to-Notebook Map

Full notebook reference: see [notebook-map.md](./docs/notebook-map.md)

Base URL for all notebooks: `https://www.pymc-marketing.io/en/stable/notebooks/mmm/`

Quick lookup for most common tasks:

| Task | Notebook slug |
|---|---|
| Quickstart | `mmm_quickstart` |
| Extensive introduction | `mmm_example` |
| Adstock transformations | `adstock_functions_guide` |
| Media saturation | `mmm_media_saturation` |
| Budget allocation | `mmm_budget_allocation_example` |
| Lift test calibration | `mmm_lift_test` |
| Cross-validation | `mmm_time_slice_cross_validation` |
| Causal identification | `mmm_causal_identification` |
| End-to-end case study | `mmm_case_study` |

Full URL pattern: `https://www.pymc-marketing.io/en/stable/notebooks/mmm/{slug}.html`

---

## Step 3: Core MMM Implementation

### Installation

```bash
pip install pymc-marketing
```

### Minimal Working Model

```python
import pandas as pd
from pymc_marketing.mmm import (
    GeometricAdstock,
    LogisticSaturation,
    MMM,
)

mmm = MMM(
    adstock=GeometricAdstock(l_max=8),
    saturation=LogisticSaturation(),
    date_column="date_week",
    channel_columns=["x1", "x2"],
    control_columns=["event_1", "event_2", "t"],
    yearly_seasonality=2,
)
```

### Key Model Components

| Component | Purpose | Common choices |
|---|---|---|
| **Adstock** | Carry-over / lag effect | `GeometricAdstock`, `WeibullAdstock` |
| **Saturation** | Diminishing returns | `LogisticSaturation`, `HillSaturation` |
| `channel_columns` | Paid media channels | List of column names in your DataFrame |
| `control_columns` | Confounders, events, trend | Trend variable `t`, holiday flags, etc. |
| `yearly_seasonality` | Seasonal Fourier terms | Integer 2–4 is typical |

### Fit the Model

```python
idata = mmm.fit(X, y)
```

### Standard Post-Fitting Workflow

1. **Prior predictive check** → `mmm.sample_prior_predictive(X)` — validate priors before seeing data
2. **MCMC diagnostics** → inspect `r_hat` and `ess_bulk` in `idata.sample_stats`
3. **Posterior predictive** → `mmm.sample_posterior_predictive(idata)`
4. **Channel contributions** → `mmm.plot_channel_contribution_share_hdi()`
5. **ROAS summary** → `mmm.get_channel_contributions_share_summary()`
6. **Budget optimization** → `mmm.optimize_budget(budget, ...)`

> For MCMC diagnostics, prior elicitation, and convergence details, load the **`pymc-modeling` skill**.

---

## Step 4: Fetch Live Documentation

When implementing any specific feature, fetch the corresponding notebook for current, runnable code:

```
https://www.pymc-marketing.io/en/stable/notebooks/mmm/{notebook-slug}.html
```

Do not rely solely on training knowledge — the API changes frequently across versions.

---

## References

- [Full Notebook Map](./docs/notebook-map.md) — Complete task-to-notebook lookup table
- [Getting Started](https://www.pymc-marketing.io/en/stable/getting_started/index.html)
- [Example Gallery](https://www.pymc-marketing.io/en/stable/gallery/gallery.html)
- [API Reference](https://www.pymc-marketing.io/en/stable/api/index.html)
- [GitHub Repository](https://github.com/pymc-labs/pymc-marketing)
