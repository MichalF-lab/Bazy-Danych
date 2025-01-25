import mysql.connector
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker(['pl_PL'])
start_date = datetime(2023, 1, 1)
end_date = datetime(2025, 1, 12)

db = mysql.connector.connect(
    host="projektdv.mysql.database.azure.com",
    user="micmat",
    password="qwertyuiop1!Q",
    database="projekt"
)

cursor = db.cursor()

def insert_pracownicy(n=10):
    for _ in range(n):
        query = """
            INSERT INTO pracownicy 
                (imie, nazwisko, email, telefon, data_zatrudnienia, 
                stanowisko, poziom_certyfikacji, kontakt_awaryjny_imie, 
                kontakt_awaryjny_telefon)
            VALUES 
                (:imie, :nazwisko, :email, :telefon, :data_zatrudnienia,
                :stanowisko, :poziom_certyfikacji, :kontakt_awaryjny_imie,
                :kontakt_awaryjny_telefon)
        """
        params = {
            'imie': fake.first_name(),
            'nazwisko': fake.last_name(),
            'email': fake.email(),
            'telefon': fake.phone_number(),
            'data_zatrudnienia': fake.date_between(start_date=start_date, end_date=end_date),
            'stanowisko': random.choice(['Instruktor', 'Przewodnik', 'Koordynator', 'Manager', 'Obsługa klienta']),
            'poziom_certyfikacji': random.choice(['Basic', 'Advanced', 'Expert', 'Expert+']),
            'kontakt_awaryjny_imie': fake.first_name(),
            'kontakt_awaryjny_telefon': fake.phone_number()
        }
        cursor.execute(query, params)


kategorie = [
    ('Survival', 'Wyprawy survivalowe i szkoła przetrwania', 'Wysokie', 'Expert Survival', True),
    ('Eventy integracyjne', 'Wydarzenia dla firm i grup', 'Niskie', 'Basic', False),
    ('Koncerty', 'Koncerty i wydarzenia muzyczne', 'Niskie', 'Basic', False),
    ('Zwiedzanie', 'Wycieczki krajoznawcze', 'Niskie', 'Basic', False),
    ('Ekstremalne', 'Wydarzenia wysokiego ryzyka', 'Bardzo wysokie', 'Expert+', True)
]

def insert_kategorie_wydarzen():
    query = """
        INSERT INTO kategorie_wydarzen
            (nazwa, opis, poziom_ryzyka,
            wymagana_certyfikacja_personelu,
            wymagane_ubezpieczenie)
        VALUES
            (%(nazwa)s, %(opis)s, %(poziom_ryzyka)s,
            %(certyfikacja)s, %(ubezpieczenie)s)
    """
    for kategoria in kategorie:
        params = {
            'nazwa': kategoria[0],
            'opis': kategoria[1],
            'poziom_ryzyka': kategoria[2],
            'certyfikacja': kategoria[3],
            'ubezpieczenie': kategoria[4]
        }
        cursor.execute(query, params)

rodzaje_wydarzen_data = [
    ('Survival amatorski', 1, 'Weekendowy kurs przetrwania', 800, 16, 15, 5, 'Góry niskie'),
    ('Survival zaawansowany', 1, 'Tygodniowy kurs przetrwania', 2500, 168, 10, 3, 'Góry wysokie'),
    ('Inscenizowane porwanie', 5, 'Symulowane porwanie na wieczór kawalerski', 1500, 6, 1, 1, 'Góry niskie'),
    ('Zwiedzanie TPN', 4, 'Wycieczka po Tatrzańskim Parku Narodowym', 100, 3, 30, 5, 'Góry'),
    ('Ekspedycja górska', 5, 'Wyprawa w wysokie góry', 5000, 72, 8, 4, 'Góry wysokie'),
    ('Wspinaczka wielkościanowa', 5, 'Całodniowa wspinaczka na długich trasach', 800, 10, 6, 2, 'Góry wysokie'),
    ('Team survival', 2, 'Survival dla firm z elementami team buildingu', 400, 8, 40, 10, 'Góry'),
    ('Zimowa integracja', 2, 'Całodniowa zimowa aktywność w górach', 450, 8, 35, 10, 'Góry niskie')
]

def insert_rodzaje_wydarzen():
    query = """
        INSERT INTO rodzaje_wydarzen 
            (nazwa, id_kategorii, opis, cena_podstawowa,
            czas_trwania_godziny, max_uczestnikow,
            min_uczestnikow, typ_lokalizacji)
        VALUES 
            (:nazwa, :kategoria_id, :opis, :cena,
            :czas, :max_ucz, :min_ucz, :lokalizacja)
    """
    for rodzaj in rodzaje_wydarzen_data:
        params = {
            'nazwa': rodzaj[0],
            'kategoria_id': rodzaj[1],
            'opis': rodzaj[2],
            'cena': rodzaj[3],
            'czas': rodzaj[4],
            'max_ucz': rodzaj[5],
            'min_ucz': rodzaj[6],
            'lokalizacja': rodzaj[7]
        }
        cursor.execute(query, params)

def insert_klienci(n=50):
    for _ in range(n):
        query = """
            INSERT INTO klienci 
                (imie, nazwisko, email, telefon, adres,
                data_urodzenia, stan_zdrowia, kontakt_awaryjny_imie,
                kontakt_awaryjny_telefon, kontakt_awaryjny_relacja)
            VALUES 
                (:imie, :nazwisko, :email, :telefon, :adres,
                :data_urodzenia, :stan_zdrowia, :kontakt_imie,
                :kontakt_tel, :kontakt_rel)
        """
        params = {
            'imie': fake.first_name(),
            'nazwisko': fake.last_name(),
            'email': fake.email(),
            'telefon': fake.phone_number(),
            'adres': fake.address(),
            'data_urodzenia': fake.date_of_birth(minimum_age=18, maximum_age=70),
            'stan_zdrowia': random.choice(['Brak przeciwwskazań', 'Lekkie ograniczenia', 'Wymaga konsultacji']),
            'kontakt_imie': fake.first_name(),
            'kontakt_tel': fake.phone_number(),
            'kontakt_rel': random.choice(['Rodzic', 'Małżonek', 'Rodzeństwo', 'Przyjaciel'])
        }
        cursor.execute(query, params)

def insert_rezerwacje(n=100):
    cursor.execute("SELECT id_klienta FROM klienci")
    klienci_ids = []
    for wiersz in cursor.fetchall():
        klienci_ids.append(wiersz[0])
    cursor.execute("SELECT id_rodzaju, cena_podstawowa FROM rodzaje_wydarzen")
    rodzaje = cursor.fetchall()
    
    for _ in range(n):
        id_rodzaju, cena_podstawowa = random.choice(rodzaje)
        data_wydarzenia = fake.date_time_between(start_date=start_date, end_date=end_date)
        data_rezerwacji = fake.date_time_between(
            start_date=start_date,
            end_date=data_wydarzenia - timedelta(days=1)
        )
        
        uczestnicy = random.randint(2, 20)
        cena = cena_podstawowa * uczestnicy * random.uniform(0.9, 1.2)
        
        query = """
            INSERT INTO rezerwacje 
                (id_klienta, id_rodzaju, data_rezerwacji,
                data_wydarzenia, status, liczba_uczestnikow,
                cena_calkowita, zgoda_podpisana)
            VALUES 
                (:klient_id, :rodzaj_id, :data_rez,
                :data_wyd, :status, :liczba_ucz,
                :cena, :zgoda)
        """
        params = {
            'klient_id': random.choice(klienci_ids),
            'rodzaj_id': id_rodzaju,
            'data_rez': data_rezerwacji,
            'data_wyd': data_wydarzenia,
            'status': random.choice(['potwierdzona', 'zakończona']),
            'liczba_ucz': uczestnicy,
            'cena': cena,
            'zgoda': True
        }
        cursor.execute(query, params)

def insert_personel_wydarzenia(n=150):
    cursor.execute("SELECT id_rezerwacji FROM rezerwacje")
    rezerwacje_ids = []
    for wiersz in cursor.fetchall():
        rezerwacje_ids.append(wiersz[0])
        cursor.execute("SELECT id_pracownika FROM pracownicy")
    pracownicy_ids = []
    for wiersz in cursor.fetchall():
        pracownicy_ids.append(wiersz[0])
    
    for _ in range(n):
        query = """
            INSERT INTO personel_wydarzenia 
                (id_rezerwacji, id_pracownika, rola, uwagi)
            VALUES 
                (:rezerwacja_id, :pracownik_id, :rola, :uwagi)
        """
        params = {
            'rezerwacja_id': random.choice(rezerwacje_ids),
            'pracownik_id': random.choice(pracownicy_ids),
            'rola': random.choice(['Prowadzący', 'Asystent', 'Koordynator', 'Obsługa techniczna', 'Opieka medyczna']),
            'uwagi': random.choice([None, 'Specjalne wymagania', 'Doświadczenie w tej kategorii', 'Pierwszy raz na tym typie wydarzenia'])
        }
        cursor.execute(query, params)

def insert_koszty_wydarzenia(n=200):
    cursor.execute("SELECT id_rezerwacji, data_wydarzenia, cena_calkowita FROM rezerwacje")
    rezerwacje = cursor.fetchall()
    
    for _ in range(n):
        rezerwacja = random.choice(rezerwacje)
        id_rezerwacji, data_wydarzenia, cena_calkowita = rezerwacja
        
        query = """
            INSERT INTO koszty_wydarzenia 
                (id_rezerwacji, typ_kosztu, kwota, opis, data_poniesienia)
            VALUES 
                (:rezerwacja_id, :typ, :kwota, :opis, :data)
        """
        
        typ_kosztu = random.choice(['sprzęt', 'transport', 'personel', 'ubezpieczenie'])
        base_cost = float(cena_calkowita) * random.uniform(0.05, 0.2)  
        
        params = {
            'rezerwacja_id': id_rezerwacji,
            'typ': typ_kosztu,
            'kwota': round(base_cost, 2),
            'opis': f"Koszt {typ_kosztu}u dla wydarzenia",
            'data': fake.date_time_between(
                start_date=data_wydarzenia - timedelta(days=30),
                end_date=data_wydarzenia
            )
        }
        cursor.execute(query, params)

def insert_transakcje_finansowe(n=300):
    cursor.execute("SELECT id_rezerwacji, cena_calkowita, data_rezerwacji, data_wydarzenia FROM rezerwacje")
    rezerwacje = cursor.fetchall()
    
    for rezerwacja in rezerwacje:
        id_rezerwacji, cena_calkowita, data_rezerwacji, data_wydarzenia = rezerwacja
        
        # Zaliczka (30% ceny)
        query = """
            INSERT INTO transakcje_finansowe 
                (id_rezerwacji, data_transakcji, kwota, typ_transakcji,
                metoda_platnosci, status, uwagi)
            VALUES 
                (:rezerwacja_id, :data, :kwota, :typ,
                :metoda, :status, :uwagi)
        """
        
        zaliczka = float(cena_calkowita) * 0.3
        params = {
            'rezerwacja_id': id_rezerwacji,
            'data': data_rezerwacji + timedelta(days=random.randint(1, 3)),
            'kwota': round(zaliczka, 2),
            'typ': 'zaliczka',
            'metoda': random.choice(['przelew', 'karta', 'gotówka']),
            'status': 'zaksięgowana',
            'uwagi': 'Zaliczka 30%'
        }
        cursor.execute(query, params)
        
        pozostala_kwota = float(cena_calkowita) - zaliczka
        params = {
            'rezerwacja_id': id_rezerwacji,
            'data': data_wydarzenia - timedelta(days=random.randint(1, 7)),
            'kwota': round(pozostala_kwota, 2),
            'typ': 'wpłata',
            'metoda': random.choice(['przelew', 'karta', 'gotówka']),
            'status': 'zaksięgowana',
            'uwagi': 'Pozostała kwota'
        }
        cursor.execute(query, params)

def insert_opinie(n=80):
    cursor.execute("SELECT id_rezerwacji, data_wydarzenia FROM rezerwacje WHERE status = 'zakończona'")
    rezerwacje = cursor.fetchall()
    
    for rezerwacja in random.sample(rezerwacje, min(n, len(rezerwacje))):
        id_rezerwacji, data_wydarzenia = rezerwacja
        
        query = """
            INSERT INTO opinie 
                (id_rezerwacji, ocena, komentarz, data_opinii)
            VALUES 
                (:rezerwacja_id, :ocena, :komentarz, :data)
        """
        
        params = {
            'rezerwacja_id': id_rezerwacji,
            'ocena': random.choices([3, 4, 5], weights=[10, 30, 60])[0],
            'komentarz': random.choice([
                'Świetna organizacja i profesjonalna obsługa!',
                'Bardzo pozytywne doświadczenie, polecam!',
                'Wszystko zgodnie z opisem, zadowoleni z wyjazdu.',
                'Super przygoda, na pewno wrócimy!',
                'Profesjonalni instruktorzy, świetna atmosfera.'
            ]),
            'data': fake.date_time_between(
                start_date=data_wydarzenia,
                end_date=data_wydarzenia + timedelta(days=14)
            )
        }
        cursor.execute(query, params)

def insert_sprzet(n=30):
    sprzet_lista = [
        ('Namiot 2-osobowy', 'Lekki namiot turystyczny'),
        ('Namiot 4-osobowy', 'Rodzinny namiot kempingowy'),
        ('Śpiwór zimowy', 'Śpiwór do -20°C'),
        ('Karimata', 'Podstawowa karimata turystyczna'),
        ('Kuchenka turystyczna', 'Kuchenka gazowa jednopalinikowa'),
        ('Plecak 60L', 'Plecak trekkingowy'),
        ('Lina wspinaczkowa', 'Lina dynamiczna 60m'),
        ('Uprząż wspinaczkowa', 'Regulowana uprząż biodrowa'),
        ('Kask wspinaczkowy', 'Kask z regulacją'),
        ('Latarka czołowa', 'Wodoodporna latarka LED')
    ]
    
    for nazwa, opis in sprzet_lista:
        for _ in range(random.randint(1, 5)):  # Multiple items of the same type
            query = """
                INSERT INTO sprzet 
                    (nazwa, opis, ilosc, stan, 
                    data_ostatniego_przegladu, data_nastepnego_przegladu)
                VALUES 
                    (:nazwa, :opis, :ilosc, :stan,
                    :ostatni_przeglad, :nastepny_przeglad)
            """
            
            data_przegladu = fake.date_between(
                start_date=start_date,
                end_date=end_date - timedelta(days=90)
            )
            
            params = {
                'nazwa': nazwa,
                'opis': opis,
                'ilosc': 1,
                'stan': random.choice(['Nowy', 'Dobry', 'Wymaga przeglądu']),
                'ostatni_przeglad': data_przegladu,
                'nastepny_przeglad': data_przegladu + timedelta(days=180)
            }
            cursor.execute(query, params)

def insert_sprzet_wydarzenia(n=200):
    cursor.execute("SELECT id_rezerwacji FROM rezerwacje")
    rezerwacje_ids = [row[0] for row in cursor.fetchall()]
    
    cursor.execute("SELECT id_sprzetu FROM sprzet")
    sprzet_ids = [row[0] for row in cursor.fetchall()]
    
    for _ in range(n):
        query = """
            INSERT INTO sprzet_wydarzenia 
                (id_rezerwacji, id_sprzetu, przydzielona_ilosc, uwagi)
            VALUES 
                (:rezerwacja_id, :sprzet_id, :ilosc, :uwagi)
        """
        
        params = {
            'rezerwacja_id': random.choice(rezerwacje_ids),
            'sprzet_id': random.choice(sprzet_ids),
            'ilosc': random.randint(1, 5),
            'uwagi': random.choice([None, 'Wymaga sprawdzenia przed wydaniem', 'Nowy sprzęt', 'Ostatnie użycie przed przeglądem'])
        }
        cursor.execute(query, params)


insert_kategorie_wydarzen()
insert_rodzaje_wydarzen()
insert_pracownicy(10)
insert_klienci(50)
insert_rezerwacje(100)
insert_personel_wydarzenia(150)
insert_koszty_wydarzenia(200)
insert_transakcje_finansowe(300)
insert_opinie(80)
insert_sprzet(30)
insert_sprzet_wydarzenia(200)

db.commit()
cursor.close()
db.close()