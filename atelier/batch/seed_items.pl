#!/usr/bin/perl
use v5.36;
use utf8;
use Encode 'decode';
use DBI qw(:sql_types);
binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";

# Install DBD::SQLite before execute this script.
# cpan install DBD::SQLite

# setting sqlite
my $dbh = DBI->connect("dbi:SQLite:dbname=../data/atelier_repo.db");
$dbh->{RaiseError} = 1; 
$dbh->{AutoCommit} = 0; # Transaction
$dbh->{sqlite_unicode} = 1; # UTF8

# item_types
my $sth = $dbh->do("DELETE FROM item_types;");
$sth = $dbh->do("DELETE FROM sqlite_sequence where name='item_types'");

$sth = $dbh->prepare("INSERT INTO item_types (id, name) VALUES (?, ?);");

my @data = (
  [ 1, '素材アイテム' ],
  [ 2, '調合アイテム' ],
);

foreach my $record (@data) {
  $sth->bind_param(1, $record->[0]);
  $sth->bind_param(2, $record->[1]);
  $sth->execute();
}

say "insert into item_types done ...";

# categories
$sth = $dbh->do("DELETE FROM categories;");
$sth = $dbh->do("DELETE FROM sqlite_sequence where name='categories'");

$sth = $dbh->prepare("INSERT INTO categories (name) VALUES (?);");

my $category_list_page = `wget -q -O - https://wikiwiki.jp/meruruplus/%E8%AA%BF%E5%90%88%E9%80%86%E5%BC%95%E3%81%8D`;
my $ul = decode('UTF-8', $category_list_page) =~ /<ul class="list1">(.*?)<\/ul>/s;
my $ul_content = $1;
while ($ul_content =~ /<li><a href="#[^"]*">\((.*?)\)<\/a><\/li>/g) {
  $sth->bind_param(1, $1);
  $sth->execute();
}

say "insert into categories done ...";

# items and items_categories
$sth = $dbh->do("DELETE FROM items;");
$sth = $dbh->do("DELETE FROM sqlite_sequence where name='items'");
$sth = $dbh->do("DELETE FROM items_categories;");
$sth = $dbh->do("DELETE FROM sqlite_sequence where name='items_categories'");

$sth = $dbh->prepare("INSERT INTO items (name, item_type_id) VALUES (?, ?);");

my $material_item_list_page = `wget -q -O - https://wikiwiki.jp/meruruplus/%E7%B4%A0%E6%9D%90%E3%82%A2%E3%82%A4%E3%83%86%E3%83%A0`;
my $tbody = decode('UTF-8', $material_item_list_page) =~ /<tbody>(.*?)<\/tbody>/;
my $tbody_content = $1;
while ($tbody_content =~ /<tr>(.*?)<\/tr>/g) {
  # insert into items
  my ($item_name, $categories) = ($1 =~ /<td [^>]*>(.*?)<\/td><td [^>]*>(.*?)<\/td>/);
  $sth->bind_param(1, $item_name);
  $sth->bind_param(2, 1);
  $sth->execute();
  my $item_id = $dbh->sqlite_last_insert_rowid();
  while ($categories =~ /\((.*?)\)/g) {
    # get category_id by name
    my $sth = $dbh->prepare("SELECT id FROM categories WHERE name = ?");
    $sth->bind_param(1, $1);
    $sth->execute();
    my $row = $sth->fetch;
    my $category_id = $row->[0];
    # insert into items_categories
    $sth = $dbh->prepare("INSERT INTO items_categories (item_id, category_id) VALUES (?, ?);");
    $sth->bind_param(1, $item_id);
    $sth->bind_param(2, $category_id);
    $sth->execute();
  }
}

say "insert into items and items_categories done ...";

$dbh->commit;
$dbh->disconnect;
