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

### Property - Represents rental listings
### Booking - Represents reservations
### Payment - Represents financial transactions
### Review - Represents property ratings and feedback
### Message - Represents communication between users

## Define the relationships between entities (e.g., User to Booking, Property to Booking)
