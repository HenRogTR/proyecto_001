package tablas;
// Generated 08/05/2014 09:52:36 AM by Hibernate Tools 3.6.0



/**
 * Usuario generated by hbm2java
 */
public class Usuario  implements java.io.Serializable {


     private Integer codUsuario;
     private Persona persona;
     private String usuario;
     private String contrasenia;
     private String ip;
     private Boolean estado;
     private Boolean p1;
     private Boolean p2;
     private Boolean p3;
     private Boolean p4;
     private Boolean p5;
     private Boolean p6;
     private Boolean p7;
     private Boolean p8;
     private Boolean p9;
     private Boolean p10;
     private Boolean p11;
     private Boolean p12;
     private Boolean p13;
     private Boolean p14;
     private Boolean p15;
     private Boolean p16;
     private Boolean p17;
     private Boolean p18;
     private Boolean p19;
     private Boolean p20;
     private Boolean p21;
     private Boolean p22;
     private Boolean p23;
     private Boolean p24;
     private Boolean p25;
     private Boolean p26;
     private Boolean p27;
     private Boolean p28;
     private Boolean p29;
     private Boolean p30;
     private Boolean p31;
     private Boolean p32;
     private Boolean p33;
     private Boolean p34;
     private Boolean p35;
     private Boolean p36;
     private Boolean p37;
     private Boolean p38;
     private Boolean p39;
     private Boolean p40;
     private Boolean p41;
     private Boolean p42;
     private Boolean p43;
     private Boolean p44;
     private Boolean p45;
     private Boolean p46;
     private Boolean p47;
     private Boolean p48;
     private Boolean p49;
     private Boolean p50;
     private Boolean p51;
     private Boolean p52;
     private Boolean p53;
     private Boolean p54;
     private Boolean p55;
     private Boolean p56;
     private Boolean p57;
     private Boolean p58;
     private Boolean p59;
     private Boolean p60;
     private String registro;

    public Usuario() {
    }

	
    public Usuario(Persona persona, String usuario, String contrasenia, String ip, String registro) {
        this.persona = persona;
        this.usuario = usuario;
        this.contrasenia = contrasenia;
        this.ip = ip;
        this.registro = registro;
    }
    public Usuario(Persona persona, String usuario, String contrasenia, String ip, Boolean estado, Boolean p1, Boolean p2, Boolean p3, Boolean p4, Boolean p5, Boolean p6, Boolean p7, Boolean p8, Boolean p9, Boolean p10, Boolean p11, Boolean p12, Boolean p13, Boolean p14, Boolean p15, Boolean p16, Boolean p17, Boolean p18, Boolean p19, Boolean p20, Boolean p21, Boolean p22, Boolean p23, Boolean p24, Boolean p25, Boolean p26, Boolean p27, Boolean p28, Boolean p29, Boolean p30, Boolean p31, Boolean p32, Boolean p33, Boolean p34, Boolean p35, Boolean p36, Boolean p37, Boolean p38, Boolean p39, Boolean p40, Boolean p41, Boolean p42, Boolean p43, Boolean p44, Boolean p45, Boolean p46, Boolean p47, Boolean p48, Boolean p49, Boolean p50, Boolean p51, Boolean p52, Boolean p53, Boolean p54, Boolean p55, Boolean p56, Boolean p57, Boolean p58, Boolean p59, Boolean p60, String registro) {
       this.persona = persona;
       this.usuario = usuario;
       this.contrasenia = contrasenia;
       this.ip = ip;
       this.estado = estado;
       this.p1 = p1;
       this.p2 = p2;
       this.p3 = p3;
       this.p4 = p4;
       this.p5 = p5;
       this.p6 = p6;
       this.p7 = p7;
       this.p8 = p8;
       this.p9 = p9;
       this.p10 = p10;
       this.p11 = p11;
       this.p12 = p12;
       this.p13 = p13;
       this.p14 = p14;
       this.p15 = p15;
       this.p16 = p16;
       this.p17 = p17;
       this.p18 = p18;
       this.p19 = p19;
       this.p20 = p20;
       this.p21 = p21;
       this.p22 = p22;
       this.p23 = p23;
       this.p24 = p24;
       this.p25 = p25;
       this.p26 = p26;
       this.p27 = p27;
       this.p28 = p28;
       this.p29 = p29;
       this.p30 = p30;
       this.p31 = p31;
       this.p32 = p32;
       this.p33 = p33;
       this.p34 = p34;
       this.p35 = p35;
       this.p36 = p36;
       this.p37 = p37;
       this.p38 = p38;
       this.p39 = p39;
       this.p40 = p40;
       this.p41 = p41;
       this.p42 = p42;
       this.p43 = p43;
       this.p44 = p44;
       this.p45 = p45;
       this.p46 = p46;
       this.p47 = p47;
       this.p48 = p48;
       this.p49 = p49;
       this.p50 = p50;
       this.p51 = p51;
       this.p52 = p52;
       this.p53 = p53;
       this.p54 = p54;
       this.p55 = p55;
       this.p56 = p56;
       this.p57 = p57;
       this.p58 = p58;
       this.p59 = p59;
       this.p60 = p60;
       this.registro = registro;
    }
   
    public Integer getCodUsuario() {
        return this.codUsuario;
    }
    
    public void setCodUsuario(Integer codUsuario) {
        this.codUsuario = codUsuario;
    }
    public Persona getPersona() {
        return this.persona;
    }
    
    public void setPersona(Persona persona) {
        this.persona = persona;
    }
    public String getUsuario() {
        return this.usuario;
    }
    
    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }
    public String getContrasenia() {
        return this.contrasenia;
    }
    
    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }
    public String getIp() {
        return this.ip;
    }
    
    public void setIp(String ip) {
        this.ip = ip;
    }
    public Boolean getEstado() {
        return this.estado;
    }
    
    public void setEstado(Boolean estado) {
        this.estado = estado;
    }
    public Boolean getP1() {
        return this.p1;
    }
    
    public void setP1(Boolean p1) {
        this.p1 = p1;
    }
    public Boolean getP2() {
        return this.p2;
    }
    
    public void setP2(Boolean p2) {
        this.p2 = p2;
    }
    public Boolean getP3() {
        return this.p3;
    }
    
    public void setP3(Boolean p3) {
        this.p3 = p3;
    }
    public Boolean getP4() {
        return this.p4;
    }
    
    public void setP4(Boolean p4) {
        this.p4 = p4;
    }
    public Boolean getP5() {
        return this.p5;
    }
    
    public void setP5(Boolean p5) {
        this.p5 = p5;
    }
    public Boolean getP6() {
        return this.p6;
    }
    
    public void setP6(Boolean p6) {
        this.p6 = p6;
    }
    public Boolean getP7() {
        return this.p7;
    }
    
    public void setP7(Boolean p7) {
        this.p7 = p7;
    }
    public Boolean getP8() {
        return this.p8;
    }
    
    public void setP8(Boolean p8) {
        this.p8 = p8;
    }
    public Boolean getP9() {
        return this.p9;
    }
    
    public void setP9(Boolean p9) {
        this.p9 = p9;
    }
    public Boolean getP10() {
        return this.p10;
    }
    
    public void setP10(Boolean p10) {
        this.p10 = p10;
    }
    public Boolean getP11() {
        return this.p11;
    }
    
    public void setP11(Boolean p11) {
        this.p11 = p11;
    }
    public Boolean getP12() {
        return this.p12;
    }
    
    public void setP12(Boolean p12) {
        this.p12 = p12;
    }
    public Boolean getP13() {
        return this.p13;
    }
    
    public void setP13(Boolean p13) {
        this.p13 = p13;
    }
    public Boolean getP14() {
        return this.p14;
    }
    
    public void setP14(Boolean p14) {
        this.p14 = p14;
    }
    public Boolean getP15() {
        return this.p15;
    }
    
    public void setP15(Boolean p15) {
        this.p15 = p15;
    }
    public Boolean getP16() {
        return this.p16;
    }
    
    public void setP16(Boolean p16) {
        this.p16 = p16;
    }
    public Boolean getP17() {
        return this.p17;
    }
    
    public void setP17(Boolean p17) {
        this.p17 = p17;
    }
    public Boolean getP18() {
        return this.p18;
    }
    
    public void setP18(Boolean p18) {
        this.p18 = p18;
    }
    public Boolean getP19() {
        return this.p19;
    }
    
    public void setP19(Boolean p19) {
        this.p19 = p19;
    }
    public Boolean getP20() {
        return this.p20;
    }
    
    public void setP20(Boolean p20) {
        this.p20 = p20;
    }
    public Boolean getP21() {
        return this.p21;
    }
    
    public void setP21(Boolean p21) {
        this.p21 = p21;
    }
    public Boolean getP22() {
        return this.p22;
    }
    
    public void setP22(Boolean p22) {
        this.p22 = p22;
    }
    public Boolean getP23() {
        return this.p23;
    }
    
    public void setP23(Boolean p23) {
        this.p23 = p23;
    }
    public Boolean getP24() {
        return this.p24;
    }
    
    public void setP24(Boolean p24) {
        this.p24 = p24;
    }
    public Boolean getP25() {
        return this.p25;
    }
    
    public void setP25(Boolean p25) {
        this.p25 = p25;
    }
    public Boolean getP26() {
        return this.p26;
    }
    
    public void setP26(Boolean p26) {
        this.p26 = p26;
    }
    public Boolean getP27() {
        return this.p27;
    }
    
    public void setP27(Boolean p27) {
        this.p27 = p27;
    }
    public Boolean getP28() {
        return this.p28;
    }
    
    public void setP28(Boolean p28) {
        this.p28 = p28;
    }
    public Boolean getP29() {
        return this.p29;
    }
    
    public void setP29(Boolean p29) {
        this.p29 = p29;
    }
    public Boolean getP30() {
        return this.p30;
    }
    
    public void setP30(Boolean p30) {
        this.p30 = p30;
    }
    public Boolean getP31() {
        return this.p31;
    }
    
    public void setP31(Boolean p31) {
        this.p31 = p31;
    }
    public Boolean getP32() {
        return this.p32;
    }
    
    public void setP32(Boolean p32) {
        this.p32 = p32;
    }
    public Boolean getP33() {
        return this.p33;
    }
    
    public void setP33(Boolean p33) {
        this.p33 = p33;
    }
    public Boolean getP34() {
        return this.p34;
    }
    
    public void setP34(Boolean p34) {
        this.p34 = p34;
    }
    public Boolean getP35() {
        return this.p35;
    }
    
    public void setP35(Boolean p35) {
        this.p35 = p35;
    }
    public Boolean getP36() {
        return this.p36;
    }
    
    public void setP36(Boolean p36) {
        this.p36 = p36;
    }
    public Boolean getP37() {
        return this.p37;
    }
    
    public void setP37(Boolean p37) {
        this.p37 = p37;
    }
    public Boolean getP38() {
        return this.p38;
    }
    
    public void setP38(Boolean p38) {
        this.p38 = p38;
    }
    public Boolean getP39() {
        return this.p39;
    }
    
    public void setP39(Boolean p39) {
        this.p39 = p39;
    }
    public Boolean getP40() {
        return this.p40;
    }
    
    public void setP40(Boolean p40) {
        this.p40 = p40;
    }
    public Boolean getP41() {
        return this.p41;
    }
    
    public void setP41(Boolean p41) {
        this.p41 = p41;
    }
    public Boolean getP42() {
        return this.p42;
    }
    
    public void setP42(Boolean p42) {
        this.p42 = p42;
    }
    public Boolean getP43() {
        return this.p43;
    }
    
    public void setP43(Boolean p43) {
        this.p43 = p43;
    }
    public Boolean getP44() {
        return this.p44;
    }
    
    public void setP44(Boolean p44) {
        this.p44 = p44;
    }
    public Boolean getP45() {
        return this.p45;
    }
    
    public void setP45(Boolean p45) {
        this.p45 = p45;
    }
    public Boolean getP46() {
        return this.p46;
    }
    
    public void setP46(Boolean p46) {
        this.p46 = p46;
    }
    public Boolean getP47() {
        return this.p47;
    }
    
    public void setP47(Boolean p47) {
        this.p47 = p47;
    }
    public Boolean getP48() {
        return this.p48;
    }
    
    public void setP48(Boolean p48) {
        this.p48 = p48;
    }
    public Boolean getP49() {
        return this.p49;
    }
    
    public void setP49(Boolean p49) {
        this.p49 = p49;
    }
    public Boolean getP50() {
        return this.p50;
    }
    
    public void setP50(Boolean p50) {
        this.p50 = p50;
    }
    public Boolean getP51() {
        return this.p51;
    }
    
    public void setP51(Boolean p51) {
        this.p51 = p51;
    }
    public Boolean getP52() {
        return this.p52;
    }
    
    public void setP52(Boolean p52) {
        this.p52 = p52;
    }
    public Boolean getP53() {
        return this.p53;
    }
    
    public void setP53(Boolean p53) {
        this.p53 = p53;
    }
    public Boolean getP54() {
        return this.p54;
    }
    
    public void setP54(Boolean p54) {
        this.p54 = p54;
    }
    public Boolean getP55() {
        return this.p55;
    }
    
    public void setP55(Boolean p55) {
        this.p55 = p55;
    }
    public Boolean getP56() {
        return this.p56;
    }
    
    public void setP56(Boolean p56) {
        this.p56 = p56;
    }
    public Boolean getP57() {
        return this.p57;
    }
    
    public void setP57(Boolean p57) {
        this.p57 = p57;
    }
    public Boolean getP58() {
        return this.p58;
    }
    
    public void setP58(Boolean p58) {
        this.p58 = p58;
    }
    public Boolean getP59() {
        return this.p59;
    }
    
    public void setP59(Boolean p59) {
        this.p59 = p59;
    }
    public Boolean getP60() {
        return this.p60;
    }
    
    public void setP60(Boolean p60) {
        this.p60 = p60;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }




}


