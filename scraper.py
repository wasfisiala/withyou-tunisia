#!/usr/bin/env python3
"""
WithYou Scraper - Tunisie
Lance le scraping légal via OpenStreetMap Overpass API
Récupère hôtels, restaurants, musées, sites archéologiques avec GPS réel
"""
import requests, json, time

OVERPASS_URL = "https://overpass-api.de/api/interpreter"

CITIES = {
    "Tunis": (36.8065, 10.1815),
    "Sousse": (35.8270, 10.6380),
    "Hammamet": (36.4000, 10.6167),
    "Djerba": (33.8076, 10.8451),
    "Kairouan": (35.6811, 10.1039),
    "Siliana": (36.0833, 9.3667),
    "Bizerte": (37.2744, 9.8739),
    "Tozeur": (33.9197, 8.1335)
}

def query_osm(lat, lon, radius=20000):
    query = f"""
    [out:json][timeout:60];
    (
      node["tourism"="hotel"](around:{radius},{lat},{lon});
      node["amenity"="restaurant"](around:{radius},{lat},{lon});
      node["tourism"="museum"](around:{radius},{lat},{lon});
      node["historic"="archaeological_site"](around:{radius},{lat},{lon});
      node["shop"="mall"](around:{radius},{lat},{lon});
    );
    out center;
    """
    r = requests.post(OVERPASS_URL, data={'data': query})
    return r.json().get('elements', [])

all_pois = []
for city, (lat, lon) in CITIES.items():
    print(f"Scraping {city}...")
    elements = query_osm(lat, lon)
    for el in elements:
        tags = el.get('tags', {})
        all_pois.append({
            'city': city,
            'name': tags.get('name', 'Sans nom'),
            'category': tags.get('tourism') or tags.get('amenity') or tags.get('historic') or tags.get('shop'),
            'lat': el.get('lat'),
            'lon': el.get('lon'),
            'address': tags.get('addr:street', '')
        })
    time.sleep(2)

with open('withyou_osm_data.json', 'w', encoding='utf-8') as f:
    json.dump(all_pois, f, ensure_ascii=False, indent=2)

print(f"Terminé: {len(all_pois)} POIs extraits")
