# terraform/vpc/variables.tf
# Intentionally minimal — candidate to extend in Phase 4

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# TODO: Add variable for enable_flow_logs (FCA audit requirement)
# TODO: Add variable for transit_gateway_id (needed for hybrid connectivity)
