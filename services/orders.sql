CREATE TYPE order_status AS ENUM (
    'created',
    'paid',
    'in_progress',
    'delivered',
    'cancelled'
);

CREATE TABLE orders (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id),
    darkstore_id UUID NOT NULL REFERENCES darkstores(id),
    delivery_address_id UUID NOT NULL REFERENCES delivery_addresses(id),
    status order_status NOT NULL DEFAULT 'created', --если статус определять в приложении, то поле status делать VARCHAR
    total_amount DECIMAL(10,2) NOT NULL,
    delivery_fee DECIMAL(10,2) NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    delivered_at TIMESTAMP WITH TIME ZONE
);

CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_delivery_address_id ON orders(delivery_address_id);
CREATE INDEX idx_orders_darkstore_id ON orders(darkstore_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);


CREATE TABLE order_items (
     id UUID PRIMARY KEY,
     order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
     product_id UUID NOT NULL REFERENCES products(id),
     quantity DECIMAL(10,3) NOT NULL,
     price DECIMAL(10,2) NOT NULL
);

CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);