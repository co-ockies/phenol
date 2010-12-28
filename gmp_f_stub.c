#include <gmp.h>

#include <malloc.h>
#include <stdio.h>
#include <string.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>

//Alouer et initialiser un mpf, puis renvoyer son pointeur
mpf_t *ptr_mpf()
{
	mpf_t *f = malloc(sizeof(mpf_t));
	mpf_init(*f);
	return f;
}

//Obtenir le pointeur de mpf contenu dans une variable Ocaml
mpf_t *Mpf_val(value bloc)
{
	return (mpf_t*) Field(bloc, 1);
}

//Fonction appelée par Ocaml lors de la destruction d'une variable contenant un mpf
void f_destroy(value bloc)
{
	mpf_clear(*Mpf_val(bloc));
	free(Mpf_val(bloc));
}

value Val_mpf(mpf_t *f)
{
	CAMLparam0();
	CAMLlocal1(bloc);
	bloc = alloc_final(2, f_destroy, sizeof(mpf_t*), 1000);
	Store_field(bloc, 1, (value) *f);
	CAMLreturn(bloc);
}

//Créer une variable Ocaml contenant un mpf de valeur val (un mpq) et de précision prec (un entier)
mpq_t *Mpq_val(value); //Définition d'une fonction externe utilisée par f_create

CAMLprim value f_create(value val, value prec)
{
	CAMLparam2(val, prec);
	CAMLlocal1(bloc);
	mpf_t* f = ptr_mpf();
	mpf_set_prec(*f, Long_val(prec));
	mpf_set_q(*f, *Mpq_val(val));
	bloc = Val_mpf(f);
	CAMLreturn(bloc);
}

//Renvoi une chaine de caractères Ocaml de la valeur du mpf contenu dans la variable Ocaml
CAMLprim value f_show(value bloc)
{
	mp_exp_t expo = 0;
	CAMLparam1(bloc);
	CAMLlocal1(val);
	char* text = mpf_get_str(NULL, &expo, 10, 0, *Mpf_val(bloc));
	char* text_final = malloc(sizeof(char) * (strlen(text) + 11));
	sprintf(text_final, "%se%ld", text, (long) expo);
	val = caml_copy_string(text_final);
	free(text_final);
	CAMLreturn(val);
}

//Fonctions arithmétiques :
/////////////////////////////////////////

CAMLprim value f_add(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpf_t* f = ptr_mpf();
	mpf_add(*f, *Mpf_val(val1), *Mpf_val(val2));
	val = Val_mpf(f);
	CAMLreturn(val);
}

CAMLprim value f_sub(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpf_t* f = ptr_mpf();
	mpf_sub(*f, *Mpf_val(val1), *Mpf_val(val2));
	val = Val_mpf(f);
	CAMLreturn(val);
}

CAMLprim value f_mul(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpf_t* f = ptr_mpf();
	mpf_mul(*f, *Mpf_val(val1), *Mpf_val(val2));
	val = Val_mpf(f);
	CAMLreturn(val);
}

CAMLprim value f_div(value val1, value val2)
{
	CAMLparam2(val1, val2);
	CAMLlocal1(val);
	mpf_t* f = ptr_mpf();
	mpf_div(*f, *Mpf_val(val1), *Mpf_val(val2));
	val = Val_mpf(f);
	CAMLreturn(val);
}

CAMLprim value f_oppos(value val)
{
	CAMLparam1(val);
	CAMLlocal1(ret);
	mpf_t* f = ptr_mpf();
	mpf_neg(*f, *Mpf_val(val));
	ret = Val_mpf(f);
	CAMLreturn(ret);
}
