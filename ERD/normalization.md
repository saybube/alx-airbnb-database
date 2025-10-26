NORMALIZATION CHANGES (3NF)
═══════════════════════════
Added:
  • Location table (from Property.location)
  • Amenity + PropertyAmenity (M:N)
  • BookingPriceBreakdown (pricing detail)
  • ReviewResponse (host replies)

Modified:
  • Property.location → Property.location_id (FK)

Benefits:
  ✓ Eliminates data redundancy
  ✓ Improves query flexibility
  ✓ Maintains 3NF compliance
  ✓ Supports scalability
