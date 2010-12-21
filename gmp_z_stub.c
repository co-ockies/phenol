#include <gmp.h>

#include <malloc.h>
#include <stdio.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>

//Allouer et initialiser un mpz, puis renvoyer son pointeur
mpz_t *ptr_mpz()
{
	mpz_t *z = malloc(sizeof(mpz_t));
	mpz_init(*z);
	return z;
}

//Obtenir le pointeur de mpz contenu dans une variable Ocaml
mpz_t *Mpz_val(value bloc)
{
	return (mpz_t*) Field(bloc, 1);
}

//Fonction appelée par Ocaml lors de la destruction d'une variable contenant un mpz
void z_destroy(value bloc)
{
	mpz_clear(*Mpz_val(bloc));
	free(Mpz_val(bloc));
}

//Créer une variable Ocaml, y mettre un mpz et la retourner
value Val_mpz(mpz_t *z)
{
	CAMLparam0();
	CAMLlocal1(bloc);
	bloc = alloc_final(2, z_destroy, sizeof(mpz_t*), 1000);
	Store_field(bloc, 1, (value) z);
	CAMLreturn(bloc);
}

//Créer une variable Ocaml contenant un mpz avec le paramettre pour valeur
CAMLprim value z_create(value val)
{
	CAMLparam1(val);
	CAMLlocal1(bloc);
	mpz_t* z = ptr_mpz();
	mpz_set_si(*z, Int_val(val));
	bloc = Val_mpz(z);
	CAMLreturn(bloc);
}

//Renvoi un entier Ocaml de valeur égale au mpz contenue dans la variable Ocaml en paramettre
CAMLprim value z_show(value bloc)
{
	CAMLparam1(bloc);
	CAMLlocal1(val);
	mpz_t* z = Mpz_val(bloc);
	val = caml_copy_string(mpz_get_str(NULL, 10, *z));
	CAMLreturn(val);
}

//Fonctions arithmétiques :
/////////////////////////////////////////

CAMLprim value z_add(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpz_t* z = ptr_mpz();
	mpz_add(*z, *Mpz_val(val1), *Mpz_val(val2));
	val = Val_mpz(z);
	CAMLreturn(val);
}

CAMLprim value z_sub(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpz_t* z = ptr_mpz();
	mpz_sub(*z, *Mpz_val(val1), *Mpz_val(val2));
	val = Val_mpz(z);
	CAMLreturn(val);
}

CAMLprim value z_mul(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpz_t* z = ptr_mpz();
	mpz_mul(*z, *Mpz_val(val1), *Mpz_val(val2));
	val = Val_mpz(z);
	CAMLreturn(val);
}

CAMLprim value z_oppos(value val)
{
	CAMLparam1(val);
	CAMLlocal1(ret);
	mpz_t* z = ptr_mpz();
	mpz_neg(*z, *Mpz_val(val));
	ret = Val_mpz(z);
	CAMLreturn(ret);
}
