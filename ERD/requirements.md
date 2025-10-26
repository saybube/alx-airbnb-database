## Identify all entities (User, Property, Booking, etc.) and their attributes.

### User
Represents guests, hosts, and admins

#### User Entity Attributes

* user_id (PK, UUID)
* first_name (VARCHAR)
* last_name (VARCHAR)
* email (VARCHAR, UNIQUE)
* password_hash (VARCHAR)
* phone_number (VARCHAR, nullable)
* role (ENUM: guest/host/admin)
* created_at (TIMESTAMP)

### Property 
Represents rental listings

#### Property Entity Attributes

* property_id (PK, UUID)
* host_id (FK → User)
* name (VARCHAR)
* description (TEXT)
* location (VARCHAR)
* pricepernight (DECIMAL)
* created_at (TIMESTAMP)
* updated_at (TIMESTAMP)

### Booking 
Represents reservations

#### Booking Entity Attributes

* booking_id (PK, UUID)
* property_id (FK → Property)
* user_id (FK → User)
* start_date (DATE)
* end_date (DATE)
* total_price (DECIMAL)
* status (ENUM: pending/confirmed/canceled)
* created_at (TIMESTAMP)

### Payment
Represents financial transactions

#### Payment Entity Attributes

* payment_id (PK, UUID)
* booking_id (FK → Booking)
* amount (DECIMAL)
* payment_date (TIMESTAMP)
* payment_method (ENUM: credit_card/paypal/stripe)

### Review 
Represents property ratings and feedback

#### Review Entity Attributes

* review_id (PK, UUID)
* property_id (FK → Property)
* user_id (FK → User)
* rating (INTEGER, 1-5)
* comment (TEXT)
* created_at (TIMESTAMP)

### Message 
Represents communication between users

#### Message Entity Attributes

* message_id (PK, UUID)
* sender_id (FK → User)
* recipient_id (FK → User)
* message_body (TEXT)
* sent_at (TIMESTAMP)

## Define the relationships between entities (e.g., User to Booking, Property to Booking)
Here are all the relationships with their cardinalities:

1. User → Property (hosts)
* One User can host many Properties (1:N)
* Each Property is hosted by one User


2. User → Booking (makes)
* One User can make many Bookings (1:N)
* Each Booking is made by one User


3. Property → Booking (has)
* One Property can have many Bookings (1:N)
* Each Booking is for one Property


4. Booking → Payment (has)
* One Booking can have many Payments (1:N)
* Each Payment belongs to one Booking


5. User → Review (writes)
* One User can write many Reviews (1:N)
* Each Review is written by one User


6. Property → Review (receives)
* One Property can receive many Reviews (1:N)
* Each Review is for one Property


7. User → Message (sends)
* One User can send many Messages (1:N)
* Each Message has one sender


8. User → Message (receives)
* One User can receive many Messages (1:N)
* Each Message has one recipient
