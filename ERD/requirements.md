// DBML for alx-airbnb-database design
// Link to diagram: https://dbdiagram.io/d/alx-airbnb-database-design-68fe8b37357668b732af2644

  Enum user_role {
    guest  
    host  
    admin  
  }

Table users {  
  user_id uuid [pk, unique, not null]    
  first_name varchar [not null]  
  last_name varchar [not null]  
  email varchar [not null, unique]  
  password_hash varchar [not null]  
  phone_number varchar [null]  
  role user_role [not null]  
  created_at timestamp [default: `CURRENT_TIMESTAMP`]  

  indexes {  
    user_id  
    email  
  }  
}

Table properties {  
  property_id uuid [pk, unique, not null]
  host_id uuid [ref: > users.user_id]
  name varchar [not null]
  description text [not null]
  location varchar [not null]
  pricepernight decimal [not null]
  created_at timestamp [default: `CURRENT_TIMESTAMP`]
  updated_at timestamp [note: "Automatically updates when record is modified"]

  indexes {
    property_id
  }
}

Enum bookings_status {
  confirmed
  pending
  canceled
}

Table bookings {
  booking_id uuid [pk, unique, not null]
  property_id uuid [ref: > properties.property_id]
  user_id uuid [ref: > users.user_id]
  start_date date [not null]
  end_date data [not null]
  total_price decimal [not null]
  status bookings_status [not null]
  created_at timestamp [default: `CURRENT_TIMESTAMP`]

  indexes {
    booking_id
  }
}

ENUM payment_method {
  credit_card
  paypal
  stripe
}

Table payments {
  payment_id uuid [pk, not null, unique]
  booking_id uuid [ref: > bookings.booking_id]
  amount decimal [not null]
  payment_date timestamp [default: `CURRENT_TIMESTAMP`]
  payment_method payment_method [not null]
}

Table reviews {
  review_id uuid [pk, not null, unique]
  property_id uuid [ref: > properties.property_id]
  user_id uuid [ref: > users.user_id]
  rating int [note: "CHECK: 1 <= rating <= 5"]
  comment text [not null]
  created_at timestamp [default: `CURRENT_TIMESTAMP`]

  indexes {
    review_id
  }
}

Table messages {
  message_id uuid [pk, not null, unique]
  sender_id uuid [ref: > users.user_id]
  recipient_id uuid [ref: > users.user_id]
  message_body text [not null]
  sent_at timestamp [default: `CURRENT_TIMESTAMP`]
}

