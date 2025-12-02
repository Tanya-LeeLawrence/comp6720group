// =========================
// MongoDB Product Attributes Seeding
// =========================

db = db.getSiblingDB("ecommerce");

db.products.drop();

// Helper for inserting with default structure
function insertProduct(product_id, sku, name, category, price, attrs, tags) {
    db.products.insertOne({
        product_id,
        sku,
        name,
        category,
        price,
        attributes: attrs,
        tags: tags || []
    });
}

// =========================
// ELECTRONICS: 1–30
// =========================

insertProduct(1, "ELEC-001", "Samsung A14 Smartphone", "Electronics", 28500.00,
    { brand: "Samsung", connectivity: "4G LTE", warranty: "1 Year" },
    ["electronics", "mobile"]);

insertProduct(2, "ELEC-002", "iPhone SE (2022)", "Electronics", 75000.00,
    { brand: "Apple", connectivity: "5G", warranty: "1 Year" },
    ["electronics", "mobile"]);

insertProduct(4, "ELEC-004", "JBL Tune 510BT Headphones", "Electronics", 9500.00,
    { brand: "JBL", wireless: true, battery_life: "40h" },
    ["audio", "wireless"]);

// 👆 We will **auto-generate** the rest shortly to avoid manual overload
// This segment shows the structure clearly
