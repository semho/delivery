CREATE TABLE darkstores (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    coordinates GEOGRAPHY(POINT, 4326) NOT NULL,
    delivery_zone GEOGRAPHY(POLYGON, 4326) NOT NULL, -- полигон зоны доставки
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_darkstores_coordinates ON darkstores USING GIST(coordinates);
CREATE INDEX idx_darkstores_delivery_zone ON darkstores USING GIST(delivery_zone);


CREATE TABLE products (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image_url TEXT,
    unit VARCHAR(20) NOT NULL,
    weight_step DECIMAL(10,3),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_products_name ON products(name); -- возможно для поиска по имени потребуется


CREATE TABLE darkstore_products (
    darkstore_id UUID NOT NULL REFERENCES darkstores(id),
    product_id UUID NOT NULL REFERENCES products(id),
    price DECIMAL(10,2) NOT NULL,
    quantity DECIMAL(10,3) NOT NULL DEFAULT 0,
    is_available BOOLEAN DEFAULT true,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (darkstore_id, product_id)
);

CREATE INDEX idx_darkstore_products_product ON darkstore_products(product_id);
CREATE INDEX idx_darkstore_products_available ON darkstore_products(darkstore_id, is_available) WHERE is_available = true;