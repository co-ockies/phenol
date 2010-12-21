#include <gmp.h>

#include <malloc.h>
#include <stdio.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>

//Alouer et initialiser un mpq, puis renvoyer son pointeur
mpq_t *ptr_mpq()
{
	mpq_t *q = malloc(sizeof(mpq_t));
	mpq_init(*q);
	return q;
}

//Obtenir le pointeur de mpq contenu dans une variable Ocaml
mpq_t *Mpq_val(value bloc)
{
	return (mpq_t*) Field(bloc, 1);
}

//Fonction appelée par Ocaml lors de la destruction d'une variable contenant un mpq
void q_destroy(value bloc)
{
	mpq_clear(*Mpq_val(bloc));
	free(Mpq_val(bloc));
}

//Créer une variable Ocaml, y mettre un mpq et la retourner
value Val_mpq(mpq_t *q)
{
	CAMLparam0();
	CAMLlocal1(bloc);
	bloc = alloc_final(2, q_destroy, sizeof(mpq_t*), 1000);
	Store_field(bloc, 1, (value) q);
	CAMLreturn(bloc);
}

//Créer une variable Ocaml contenant un mpq avec le parametre pour valeur
CAMLprim value q_create(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(bloc);
	mpq_t* q = ptr_mpq();
	mpq_set_si(*q, Int_val(val1), Int_val(val2));
	mpq_canonicalize(*q);
	bloc = Val_mpq(q);
	CAMLreturn(bloc);
}

//Renvoi une chaine de caractères Ocaml de la valeur du mpq contenue dans la variable Ocaml
CAMLprim value q_show(value bloc)
{
	CAMLparam1(bloc);
	CAMLlocal1(val);
	mpq_t* q = Mpq_val(bloc);
	mpq_canonicalize(*q);
	val = caml_copy_string(mpq_get_str(NULL, 10, *q));
	CAMLreturn(val);
}

//Créer un q égal à un z

mpz_t *Mpz_val(value);//Definition d'une fonction externe utilisée
//par q_of_z .

CAMLprim value q_of_z(value bloc)
{
	CAMLparam1(bloc);
	CAMLlocal1(val);
	mpz_t* z = Mpz_val(bloc);
	mpq_t* q = ptr_mpq();
	mpq_set_z(*q, *z);
	val = Val_mpq(q);
	CAMLreturn(val);
}
//Fonctions arithmétiques :
/////////////////////////////////////////

CAMLprim value q_add(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpq_t* q = ptr_mpq();
	mpq_add(*q, *Mpq_val(val1), *Mpq_val(val2));
	mpq_canonicalize(*q);
	val = Val_mpq(q);
	CAMLreturn(val);
}

CAMLprim value q_sub(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpq_t* q = ptr_mpq();
	mpq_sub(*q, *Mpq_val(val1), *Mpq_val(val2));
	mpq_canonicalize(*q);
	val = Val_mpq(q);
	CAMLreturn(val);
}


CAMLprim value q_mul(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpq_t* q = ptr_mpq();
	mpq_mul(*q, *Mpq_val(val1), *Mpq_val(val2));
	mpq_canonicalize(*q);
	val = Val_mpq(q);
	CAMLreturn(val);
}

CAMLprim value q_div(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpq_t* q = ptr_mpq();
	mpq_div(*q, *Mpq_val(val1), *Mpq_val(val2));
	mpq_canonicalize(*q);
	val = Val_mpq(q);
	CAMLreturn(val);
}

CAMLprim value q_oppos(value val)
{
	CAMLparam1(val);
	CAMLlocal1(ret);
	mpq_t* q = ptr_mpq();
	mpq_neg(*q, *Mpq_val(val));
	ret = Val_mpq(q);
	CAMLreturn(ret);
}
