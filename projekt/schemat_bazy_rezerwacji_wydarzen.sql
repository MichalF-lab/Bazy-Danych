-- Tabela pracowników
CREATE TABLE pracownicy (
    id_pracownika INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefon VARCHAR(15) NOT NULL,
    data_zatrudnienia DATE NOT NULL,
    stanowisko VARCHAR(50) NOT NULL,
    poziom_certyfikacji VARCHAR(30),
    kontakt_awaryjny_imie VARCHAR(100),
    kontakt_awaryjny_telefon VARCHAR(15)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela kategorii wydarzeń
CREATE TABLE kategorie_wydarzen (
    id_kategorii INT AUTO_INCREMENT PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    opis TEXT,
    poziom_ryzyka VARCHAR(20),
    wymagana_certyfikacja_personelu VARCHAR(30),
    wymagane_ubezpieczenie BOOLEAN DEFAULT FALSE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela rodzajów wydarzeń
CREATE TABLE rodzaje_wydarzen (
    id_rodzaju INT AUTO_INCREMENT PRIMARY KEY,
    id_kategorii INT,
    nazwa VARCHAR(200) NOT NULL,
    opis TEXT,
    cena_podstawowa DECIMAL(10,2) NOT NULL,
    czas_trwania_godziny INT NOT NULL,
    max_uczestnikow INT,
    min_uczestnikow INT,
    typ_lokalizacji VARCHAR(50),
    wymagany_sprzet TEXT,
    FOREIGN KEY (id_kategorii) REFERENCES kategorie_wydarzen(id_kategorii)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela klientów
CREATE TABLE klienci (
    id_klienta INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefon VARCHAR(15) NOT NULL,
    adres TEXT,
    data_urodzenia DATE,
    stan_zdrowia TEXT,
    kontakt_awaryjny_imie VARCHAR(100),
    kontakt_awaryjny_telefon VARCHAR(15),
    kontakt_awaryjny_relacja VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela rezerwacji
CREATE TABLE rezerwacje (
    id_rezerwacji INT AUTO_INCREMENT PRIMARY KEY,
    id_klienta INT,
    id_rodzaju INT,
    data_rezerwacji TIMESTAMP NOT NULL,
    data_wydarzenia TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL, -- 'oczekująca', 'potwierdzona', 'zakończona', 'anulowana'
    liczba_uczestnikow INT NOT NULL,
    cena_calkowita DECIMAL(10,2) NOT NULL,
    dodatkowe_wymagania TEXT,
    zgoda_podpisana BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_klienta) REFERENCES klienci(id_klienta),
    FOREIGN KEY (id_rodzaju) REFERENCES rodzaje_wydarzen(id_rodzaju)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela przydziału pracowników do wydarzeń
CREATE TABLE personel_wydarzenia (
    id_przydzialu INT AUTO_INCREMENT PRIMARY KEY,
    id_rezerwacji INT,
    id_pracownika INT,
    rola VARCHAR(50) NOT NULL,
    uwagi TEXT,
    FOREIGN KEY (id_rezerwacji) REFERENCES rezerwacje(id_rezerwacji),
    FOREIGN KEY (id_pracownika) REFERENCES pracownicy(id_pracownika)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela kosztów organizacji
CREATE TABLE koszty_wydarzenia (
    id_kosztu INT AUTO_INCREMENT PRIMARY KEY,
    id_rezerwacji INT,
    typ_kosztu VARCHAR(50) NOT NULL, -- 'sprzęt', 'transport', 'personel', 'ubezpieczenie'
    kwota DECIMAL(10,2) NOT NULL,
    opis TEXT,
    data_poniesienia TIMESTAMP NOT NULL,
    FOREIGN KEY (id_rezerwacji) REFERENCES rezerwacje(id_rezerwacji)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela transakcji finansowych
CREATE TABLE transakcje_finansowe (
    id_transakcji INT AUTO_INCREMENT PRIMARY KEY,
    id_rezerwacji INT,
    data_transakcji TIMESTAMP NOT NULL,
    kwota DECIMAL(10,2) NOT NULL,
    typ_transakcji VARCHAR(20) NOT NULL, -- 'wpłata', 'zwrot', 'zaliczka'
    metoda_platnosci VARCHAR(50),
    status VARCHAR(20) NOT NULL,
    uwagi TEXT,
    FOREIGN KEY (id_rezerwacji) REFERENCES rezerwacje(id_rezerwacji)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela ocen i opinii
CREATE TABLE opinie (
    id_opinii INT AUTO_INCREMENT PRIMARY KEY,
    id_rezerwacji INT,
    ocena INT CHECK (ocena BETWEEN 1 AND 5),
    komentarz TEXT,
    data_opinii TIMESTAMP NOT NULL,
    FOREIGN KEY (id_rezerwacji) REFERENCES rezerwacje(id_rezerwacji)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela sprzętu
CREATE TABLE sprzet (
    id_sprzetu INT AUTO_INCREMENT PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    opis TEXT,
    ilosc INT NOT NULL,
    stan VARCHAR(20),
    data_ostatniego_przegladu DATE,
    data_nastepnego_przegladu DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Tabela przypisania sprzętu do wydarzeń
CREATE TABLE sprzet_wydarzenia (
    id_przydzialu_sprzetu INT AUTO_INCREMENT PRIMARY KEY,
    id_rezerwacji INT,
    id_sprzetu INT,
    przydzielona_ilosc INT NOT NULL,
    uwagi TEXT,
    FOREIGN KEY (id_rezerwacji) REFERENCES rezerwacje(id_rezerwacji),
    FOREIGN KEY (id_sprzetu) REFERENCES sprzet(id_sprzetu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;