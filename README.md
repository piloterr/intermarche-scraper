<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Intermarché Scraper API by Piloterr – scrape Intermarché data as JSON" width="100%"></a>
</p>

# Intermarché Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Intermarché Scraper API** lets you extract public data from Intermarché as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Intermarché Product API** — Get an Intermarché product sheet for a store (shop_id).
- **Intermarché Search API** — Search Intermarché products for a store (shop_id).

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Intermarché Product API](#intermarché-product-api) | `/v2/intermarche/product` | 3 | Get an Intermarché product sheet for a store (shop_id). Try an EAN or product URL with shop_id=11301. 3 credits per call. |
| [Intermarché Search API](#intermarché-search-api) | `/v2/intermarche/search` | 3 | Search Intermarché products for a store (shop_id). Try query=lait and shop_id=11301. 3 credits per call. |

## Table of contents

- [How it works](#how-it-works)
- [Intermarché Product API](#intermarché-product-api)
- [Intermarché Search API](#intermarché-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Intermarché Product API

Get an Intermarché product sheet for a store (shop_id). Try an EAN or product URL with shop_id=11301. 3 credits per call.

`GET | POST https://api.piloterr.com/v2/intermarche/product` · **3 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Full Intermarché product URL, or an EAN barcode. |
| `shop_id` | string | ✅ | Intermarché store id. Resolve a city with the [Stores Finder](https://www.piloterr.com/library/finder-intermarche-stores) (for example `query=Paris`). |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/intermarche/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.intermarche.com/produit/flan-patissier-cuit-&-dore-au-four/3250391522828",
        "shop_id": "11301",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type IntermarchProduct = {
  ean?: string;
  url?: string;
  unit?: string;
  brand?: string;
  image?: string;
  price?: number;
  stock?: number;
  title?: string;
  images?: string[];
  origin?: string;
  shop_id?: string;
  capacity?: number;
  currency?: string;
  in_stock?: boolean;
  packaging?: string;
  was_price?: unknown;
  nutriscore?: string;
  unit_price?: number;
  description?: string;
  price_display?: string;
};

const params = new URLSearchParams({
  "query": "https://www.intermarche.com/produit/flan-patissier-cuit-&-dore-au-four/3250391522828",
  "shop_id": "11301",
});

const response = await fetch(`https://api.piloterr.com/v2/intermarche/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as IntermarchProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/intermarche/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.intermarche.com/produit/flan-patissier-cuit-&-dore-au-four/3250391522828", "shop_id": "11301"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "ean": "3250391522828",
  "url": "https://www.intermarche.com/produit/flan-patissier-cuit-&-dore-au-four/3250391522828",
  "unit": "€/Kg",
  "brand": "Pâturages, une marque Intermarché",
  "image": "https://assets-big.cdn-mousquetaires.com/medias/domain11815/media131044/9313237-larns7kgb4-ecommint.jpg",
  "price": 3.06,
  "stock": 8,
  "title": "Flan pâtissier, cuit & doré au four",
  "images": [
    "https://assets-big.cdn-mousquetaires.com/medias/domain11815/media131044/9313237-larns7kgb4-ecommint.jpg"
  ],
  "origin": "France",
  "shop_id": "11301",
  "capacity": 400,
  "currency": "EUR",
  "in_stock": true,
  "packaging": "les 4 pots de 100 g - 400g",
  "was_price": null,
  "nutriscore": "C",
  "unit_price": 7.65,
  "description": "Flan Pâtissier",
  "price_display": "3,06 €"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `ean` | string |  |
| `url` | string |  |
| `unit` | string |  |
| `brand` | string |  |
| `image` | string |  |
| `price` | number |  |
| `stock` | integer |  |
| `title` | string |  |
| `images` | string[] |  |
| `origin` | string |  |
| `shop_id` | string |  |
| `capacity` | integer |  |
| `currency` | string |  |
| `in_stock` | boolean |  |
| `packaging` | string |  |
| `was_price` | object |  |
| `nutriscore` | string |  |
| `unit_price` | number |  |
| `description` | string |  |
| `price_display` | string |  |

## Intermarché Search API

Search Intermarché products for a store (shop_id). Try query=lait and shop_id=11301. 3 credits per call.

`GET | POST https://api.piloterr.com/v2/intermarche/search` · **3 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Search keyword or full Intermarché search URL. |
| `shop_id` | string | ✅ | Intermarché store id. Resolve a city with the [Stores Finder](https://www.piloterr.com/library/finder-intermarche-stores) (for example `query=Paris`). |
| `page` | number | — | Page number starting at `1`. Use `pagination.total_pages` from a previous response to iterate. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/intermarche/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "lait",
        "shop_id": "11301",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type IntermarchSearch = {
  results?: {
    ean?: string;
    url?: string;
    brand?: string;
    image?: string;
    price?: number;
    title?: string;
    shop_id?: string;
    currency?: string;
    position?: number;
    packaging?: string;
    unit_price?: string;
    price_display?: string;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "lait",
  "shop_id": "11301",
});

const response = await fetch(`https://api.piloterr.com/v2/intermarche/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as IntermarchSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/intermarche/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "lait", "shop_id": "11301"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "ean": "3533630097654",
      "url": "https://www.intermarche.com/produit/grandlait-frais-lait-frais-de-montagne-entier/3533630097654",
      "brand": "Grandlait",
      "image": "https://assets-big.cdn-mousquetaires.com/medias/domain11815/media140040/12012075-ubbxcayb3o-ecommint.jpg",
      "price": 1.61,
      "title": "Grandlait frais - Lait frais de Montagne entier",
      "shop_id": "11301",
      "currency": "EUR",
      "position": 1,
      "packaging": "la bouteille de 1 l",
      "unit_price": "1,61 €/L",
      "price_display": "1,61 €"
    },
    {
      "ean": "3451790000840",
      "url": "https://www.intermarche.com/produit/candia-grandlait-lait-entier/3451790000840",
      "brand": "Candia",
      "image": null,
      "price": 1.29,
      "title": "Candia GrandLait - Lait entier",
      "shop_id": "11301",
      "currency": "EUR",
      "position": 2,
      "packaging": "la bouteille de 1 l",
      "unit_price": "1,29 €/L",
      "price_display": "1,29 €"
    }
  ],
  "pagination": {
    "next": "https://www.intermarche.com/recherche/lait?page=2",
    "page": 1,
    "per_page": 40,
    "total_pages": 15,
    "total_results": 588
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].ean` | string |  |
| `results[].url` | string |  |
| `results[].brand` | string |  |
| `results[].image` | string |  |
| `results[].price` | number |  |
| `results[].title` | string |  |
| `results[].shop_id` | string |  |
| `results[].currency` | string |  |
| `results[].position` | integer |  |
| `results[].packaging` | string |  |
| `results[].unit_price` | string |  |
| `results[].price_display` | string |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Intermarché plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Intermarché?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/intermarche/product` **3**, `/v2/intermarche/search` **3**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Intermarché API return?

Each endpoint returns structured JSON: **Intermarché Product** — `ean`, `url`, `unit`, `brand`, `image`, `price`; **Intermarché Search** — `results[]`, `results[].ean`, `results[].url`, `results[].brand`, `results[].image`, `results[].price`.

### How do I paginate Intermarché results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Intermarché is a trademark of its respective owner. This repository is not affiliated with or endorsed by Intermarché. Examples are released under the MIT license.</sub>
