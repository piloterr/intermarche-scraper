#!/usr/bin/env bash
# Intermarché Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/intermarche/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode 'query=https://www.intermarche.com/produit/flan-patissier-cuit-&-dore-au-four/3250391522828' \
  --data-urlencode shop_id=11301
