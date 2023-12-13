#!/bin/bash

# Array of Tenant Key Values
TENANT_KEY_VALUES=(
    "e242795b-178a-49d7-bab4-6a2a945c3771"
    "e3a08351-7587-488f-8523-9d1d4d251b4a"
    "e2324797-bef4-41e2-b9bc-1acae855eceb"
    "c9a28a61-fa79-4b00-b308-f0fe8e8bdb78"
    "ee7f446b-488a-47f6-8251-f32ea069060c"
    "94ddfce5-be1e-4916-8e8b-6f257b1fce27"
    "b2422a5a-79af-4afa-b249-bb68bb3d45b0"
    "d83d027f-9d2d-4f11-b53a-a73e24bf3465"
    "529a73ba-f1da-46c2-a527-f6f891b2901d"
    "ae2b9779-ae3c-4c31-9a71-f5042e3df35d"
    "1c05648d-07f9-48e4-a1c7-6807ba99046d"
    "7e31c666-2880-4cca-9a9b-5d63108bd4fa"
)

# Counter for container names
counter=1

# Loop through each Tenant Key Value
for TENANT_KEY in "${TENANT_KEY_VALUES[@]}"; do
    echo "Running Docker for Tenant Key: $TENANT_KEY"
    docker run -d -e TENANT_KEY_VALUE=$TENANT_KEY --name container${counter} mmtest:importing2
    counter=$((counter+1))
    # The containers are now running in detached mode (-d)
done

echo "All Docker commands have been executed."