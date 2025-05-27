CREATE TABLE users (
   id UUID PRIMARY KEY,
   phone VARCHAR(20) UNIQUE NOT NULL,
   name VARCHAR(255),
   email VARCHAR(255) UNIQUE,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_users_phone ON users(email);


CREATE TABLE payment_cards (
   id UUID PRIMARY KEY,
   user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
   payment_token VARCHAR(255) UNIQUE NOT NULL,
   card_last4 VARCHAR(4) NOT NULL,
   card_type VARCHAR(20),
   is_active BOOLEAN DEFAULT true,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_payment_cards_user_id ON payment_cards(user_id);


CREATE TABLE delivery_addresses (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    address TEXT NOT NULL,
    coordinates GEOGRAPHY(POINT, 4326) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_delivery_addresses_user_id ON delivery_addresses(user_id);
CREATE INDEX idx_delivery_addresses_coordinates ON delivery_addresses USING GIST(coordinates);
