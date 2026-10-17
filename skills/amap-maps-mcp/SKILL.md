---
name: amap-maps-mcp
description: Use when the user invokes $amap-maps-mcp, mentions Amap Maps, or asks for supported Amap Maps workflows.
---

# Amap Maps

## Overview

Use this skill for requests that should be answered through the Amap Maps MCP. The verified scope is limited to the operations listed in the catalog below. The catalog comes from the provider's live detail-page metadata; verify live callable availability before execution.

## Core Rules

- Use the bound `amap-maps-mcp` MCP only when its live callable tools are available in the current runtime.
- Select the narrowest live callable operation that directly answers the request; follow the live interface when it differs from this guide.
- Do not invent provider facts, identifiers, statuses, dates, prices, records, files, or metrics from memory.
- Keep secrets, private content, and authorization material out of prompts, logs, and final answers. Never ask the user to paste credentials into chat.
- Do not use shell commands, direct HTTP calls, or hand-written JSON-RPC to recreate, probe, or simulate the MCP server.
- Treat provider output as evidence. Label model interpretation, calculations, or recommendations separately.
- Require explicit confirmation before any external write, send, purchase, order, deletion, publication, merge, or permission change.


## Tools
- `maps_text_search`: Searches points of interest by keyword and returns related place information.
- `maps_around_search`: Searches for points of interest matching a keyword within a radius around coordinates.
- `maps_search_detail`: Retrieves details for a point-of-interest ID returned by a keyword or nearby search.
- `maps_geo`: Converts a structured address, landmark, or building name into geographic coordinates.
- `maps_regeocode`: Converts an Amap coordinate into an administrative address.
- `maps_ip_location`: Locates the area associated with an IP address.
- `maps_weather`: Retrieves weather for a city name or standard administrative code.
- `maps_distance`: Measures distance between coordinates using driving, walking, or spherical-distance calculations.
- `maps_direction_driving`: Plans a passenger-car route between origin and destination coordinates.
- `maps_direction_walking`: Plans a walking route between coordinates within the supported distance range.
- `maps_direction_bicycling`: Plans a bicycling route while accounting for route restrictions such as overpasses, one-way roads, and closures.
- `maps_direction_transit_integrated`: Plans an integrated train, bus, or metro route between locations, including cross-city transit planning.
- `maps_schema_navi`: Builds a URI that opens the map client on a navigation page for a destination.
- `maps_schema_take_taxi`: Builds a URI that opens the map client for taxi travel between an origin and destination.
- `maps_schema_personal_map`: Builds a URI that displays itinerary locations in travel order in the map client.
- Select the narrowest live callable tool that directly answers the request. Follow the live callable interface for current inputs, outputs, and errors.

## Workflow

1. Identify the relevant entity or resource, identifier, scope, date or time range, filters, and requested output.
2. Classify the request as lookup, retrieval, search, analysis, creation, update, export, deletion, sending, purchase, permission change, or another provider operation before routing.
3. Resolve ambiguous identifiers with a live lookup when available; never guess a code, ID, path, coordinate, record, order, or account.
4. Pass only supported arguments and preserve provider pagination, status, units, timestamps, and returned identifiers.
5. Chain operations only when a returned identifier, status, or structured result is required by the next operation.
6. Inspect the outer MCP error and provider status before reading result fields. Do not treat an empty or partial response as success without reporting its scope.

## Query Guidance

- Ask only for missing inputs that are required to choose or safely execute the operation.
- Preserve the user's requested scope and normalize names, dates, identifiers, or formats only when the mapping is unambiguous; state any normalization.
- Keep unrelated entities, time windows, accounts, and writes separate.
- State filters, page or result limits, sort order, output format, and data time when available.
- Add only provider-specific required context and confirmation boundaries supported by evidence.

## Failure Handling

- If no live Amap Maps callable tool is present, stop MCP execution and report that the connector is unavailable in the current runtime.
- For authorization, quota, timeout, invalid-argument, permission, provider, or missing-tool errors, report the failed operation without exposing secrets.
- Retry at most once only after a safe correction such as narrowing scope, supplying a known identifier, reducing page size, or removing an unsupported optional field.
- For empty or partial results, report the exact query scope and provider status; do not fill missing fields from memory or another source.
- If the user specifically requests this connector, do not silently substitute another provider. State the connector failure first and offer a clearly labeled fallback only if the user wants it.

## Result Contract

- Separate returned provider facts from model interpretation and derived calculations.
- Preserve identifiers, URLs, paths, dates, timestamps, units, filters, page scope, totals, status, and provider caveats when returned.
- Do not describe one page, sample, or preview as complete unless the provider confirms completeness.
- Repeat only the highest-risk provider-specific caveat when it materially affects the result.
