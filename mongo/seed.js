{
  "_id": ObjectId("..."),
  "product_id": 101,         
  "sku": "SWATCH-001",
  "name": "Smart Fitness Watch",
  "category": "electronics",
  "price": 129.99,
  "attributes": {             // flexible subdocument
    "brand": "FitPro",
    "battery_life_hours": 24,
    "water_resistant": true,
    "heart_rate_monitor": true,
    "screen_size_inches": 1.3
  },
  "tags": ["fitness", "wearable", "bluetooth"],
  "popularity_score": 0,      // can be updated after orders
  "last_updated": ISODate("2025-12-01T00:00:00Z")
}

{
  "product_id": 205,
  "sku": "TSHIRT-RED-M",
  "name": "Classic Red T-Shirt",
  "category": "clothing",
  "price": 19.99,
  "attributes": {
    "brand": "ComfortWear",
    "size": "M",
    "material": "Cotton",
    "gender": "unisex",
    "color": "red"
  },
  "tags": ["tshirt", "casual", "unisex"],
  "popularity_score": 0,
  "last_updated": ISODate("2025-12-01T00:00:00Z")
}

db.catalog.createIndex({ category: 1 });
db.catalog.createIndex({ "attributes.brand": 1 });
db.catalog.createIndex({ popularity_score: -1 });


// Find popular waterproof electronics with long battery life
db.catalog.find({
  category: "electronics",
  "attributes.water_resistant": true,
  "attributes.battery_life_hours": { $gte: 20 }
}).sort({ popularity_score: -1 }).limit(10);


{
  "product_id": 67,
  "sku": "BEACH-067",
  "name": "Rasta Mesh Marina",
  "category": "Beachwear",
  "price": 2900.50,
  "attributes": {
    "brand": "Island Traditions",
    "gender": "Men",
    "material": "Poly Mesh",
    "style": "Rastafari Colors"
  },
  "tags": ["beachwear", "jamaica", "summer"]
}



