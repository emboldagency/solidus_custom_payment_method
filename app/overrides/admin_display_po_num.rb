# frozen_string_literal: true

Deface::Override.new(
    virtual_path: "spree/admin/payments/_list",
    name: "admin_payments_list_remove_link",
    replace_contents: "[data-hook=payments_row] td:nth-child(1)",
    partial: "spree/admin/payments/_list/payment_number",
)

Deface::Override.new(
    virtual_path: "spree/admin/payments/_list",
    name: "admin_payments_list_add_po_num",
    replace_contents: "[data-hook=payments_row] td:nth-child(3)",
    partial: "spree/admin/payments/_list/payment_method",
)
