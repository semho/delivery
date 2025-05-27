CREATE TABLE couriers (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    current_location GEOGRAPHY(POINT, 4326),
    is_available BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_couriers_available ON couriers(is_available);
CREATE INDEX idx_couriers_location ON couriers USING GIST(current_location);


CREATE TABLE order_delivery (
    order_id UUID PRIMARY KEY REFERENCES orders(id),
    courier_id UUID NOT NULL REFERENCES couriers(id),
    assigned_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    delivered_at TIMESTAMP WITH TIME ZONE
);

CREATE INDEX idx_order_delivery_courier ON order_delivery(courier_id);


CREATE TABLE courier_tracking (
    id UUID PRIMARY KEY,
    order_id UUID NOT NULL REFERENCES orders(id),
    location GEOGRAPHY(POINT, 4326) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_courier_tracking_order ON courier_tracking(order_id, created_at DESC);