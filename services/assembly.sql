CREATE TABLE assemblers (
    id UUID PRIMARY KEY,
    darkstore_id UUID NOT NULL REFERENCES darkstores(id),
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_assemblers_darkstore ON assemblers(darkstore_id);


CREATE TABLE order_assembly (
    order_id UUID PRIMARY KEY REFERENCES orders(id),
    assembler_id UUID NOT NULL REFERENCES assemblers(id),
    assigned_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP WITH TIME ZONE
);

CREATE INDEX idx_order_assembly_assembler ON order_assembly(assembler_id);