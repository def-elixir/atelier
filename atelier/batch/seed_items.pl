#!/usr/bin/perl
use v5.36;
use utf8;
use Encode 'decode';
use DBI;
use DBI qw(:sql_types);
binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";

my $dbh = DBI->connect("dbi:SQLite:dbname=../data/atelier_repo.db");
$dbh->{RaiseError} = 1; 
$dbh->{AutoCommit} = 0; # Transaction
$dbh->{sqlite_unicode} = 1; # UTF8

# item_types
my $sth = $dbh->do("DELETE FROM item_types;");
$sth = $dbh->do("DELETE FROM sqlite_sequence where name='item_types'");
$dbh->commit;

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
$dbh->commit;

say "insert into item_types done ...";

# categories
$sth = $dbh->do("DELETE from categories;");
$sth = $dbh->do("DELETE FROM sqlite_sequence where name='categories'");
$dbh->commit;

$sth = $dbh->prepare("INSERT INTO categories (name) VALUES (?);");

my $category_list_page = `wget -q -O - https://wikiwiki.jp/meruruplus/%E8%AA%BF%E5%90%88%E9%80%86%E5%BC%95%E3%81%8D`;
my $ul = decode('UTF-8', $category_list_page) =~ /<ul class="list1">(.*?)<\/ul>/s;
my $ul_content = $1;
while ($ul_content =~ /<li><a href="#[^"]*">\((.*?)\)<\/a><\/li>/g) {
  $sth->bind_param(1, $1);
  $sth->execute();
}
$dbh->commit;

say "insert into categories done ...";

$dbh->disconnect;
