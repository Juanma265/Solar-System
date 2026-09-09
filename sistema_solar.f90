PROGRAM sistema_solar
    REAL, DIMENSION(9) :: x,y,v_x,v_y,m
    REAL, DIMENSION(9,2) :: r,v,a,r_ajustada
    REAL, DIMENSION(9) :: prev_angle, total_angle, period_years, moment_angular
    REAL :: angle_curr, dtheta, PI, moment_total
    LOGICAL, DIMENSION(9) :: period_found
    REAL :: h,t,t_sim,dist, kinetic, potential, energy_total
    INTEGER :: i,j,k,step,choice
    LOGICAL :: heliocentric
    CHARACTER(10), DIMENSION(9) :: planetas 

    PI = 3.14159265
    total_angle = 0.0
    period_found = .FALSE.
    moment_total = 0.0

    planetas(1)="Sol       "
    planetas(2)="Mercurio  "
    planetas(3)="Venus     "
    planetas(4)="Tierra    "
    planetas(5)="Marte     "
    planetas(6)="Jupiter   "
    planetas(7)="Saturno   "
    planetas(8)="Urano     "
    planetas(9)="Neptuno   "

    !Posiciones iniciales de los planetas en UA
    x(1)=0. !Sol
    x(2)= 0.4666 !Afelio de Mercurio
    x(3)=0.
    x(4)=1.0167 !Afelio de la Tierra
    x(5)=0.
    x(6)=5.4586 !Afelio de Júpiter
    x(7)=0.
    x(8)=20.0775 !Afelio de Urano
    x(9)=0.

    y(1)=0. !Sol
    y(2)=0.
    y(3)=0.7189 !Perihelio de Venus
    y(4)=0.
    y(5)=1.38102 !Perihelio de Marte
    y(6)=0.
    y(7)=9.04144 !Perihelio de Saturno
    y(8)=0.
    y(9)=29.7092!Perihelio de Neptuno

    !Velocidades iniciales de los planetas en UA/año

    v_x(1)=0.
    v_x(2)=0.
    v_x(3)=-1.184
    v_x(4)=0.
    v_x(5)=-0.890
    v_x(6)=0.
    v_x(7)=-0.341
    v_x(8)=0.
    v_x(9)=-0.184

    v_y(1)=0.
    v_y(2)=1.304
    v_y(3)=0.
    v_y(4)=0.983
    v_y(5)=0.
    v_y(6)=0.408
    v_y(7)=0.
    v_y(8)=0.218
    v_y(9)=0.

    !Masa de los planetas en masas solares
    m(1)=1.
    m(2)=0.000000165
    m(3)=0.000002435
    m(4)=0.000002985
    m(5)=0.000000321
    m(6)=0.000949
    m(7)=0.000284
    m(8)=0.0000434
    m(9)=0.000051

    t= 0. !Tiempo inicial

    open (1, file="sistema_solar.txt", status="replace")
    open (2, file="periodos_planetas.txt", status="replace")
    open (3, file="momentos_planetas.txt", status="replace")
    open (4, file="energia_sistema.txt", status="replace")

    write (*,*) "Elija el sistema de referencia:"
    write (*,*) "1. Heliocentrico (Sol en el centro)"
    write (*,*) "2. Geocentrico (Tierra en el centro)"
    read (*,*) choice

    if (choice == 1) then
        heliocentric = .TRUE.
    else
        heliocentric = .FALSE.
    end if

    write (*,*) "Time simulation (years):"
    read (*,*) t_sim 
    write (*,*) "Paso: "
    read (*,*) h

    t_sim=t_sim*6.27912 !Convertir años a tiempo reescalado
    step = 0.0
    period_steps = 0.0

    do i=1,9
        r(i,1)=x(i)
        v(i,1)=v_x(i)
        r(i,2)=y(i)
        v(i,2)=v_y(i)
        a(i,1) = 0.0
        a(i,2) = 0.0
        moment_angular(i) = 0.0
    end do 

    !Calcular aceleraciones iniciales (Ley de gravitación universal)
    do i=1,9
        a(i,1) = 0.0
        a(i,2) = 0.0
        do j=1,9
            if (j /= i) then
                dist = sqrt((r(i,1)-r(j,1))**2 + (r(i,2)-r(j,2))**2)
                a(i,1) = a(i,1) - m(j) * (r(i,1) - r(j,1)) / dist**3
                a(i,2) = a(i,2) - m(j) * (r(i,2) - r(j,2)) / dist**3
            end if
        end do
    end do

    !Calcular ángulos iniciales para cada planeta
    do i=1,9
        prev_angle(i) = atan2(r(i,2), r(i,1))
        total_angle(i) = 0.0
        period_years(i) = 0.0
    end do


    !Bucle para calcular posiciones y velocidades de los planetas a lo largo del tiempo
    do while (t<t_sim)
        ! Actualizar posiciones
        do i=1,9
            r(i,1) = r(i,1) + v(i,1)*h + 0.5*a(i,1)*h**2
            r(i,2) = r(i,2) + v(i,2)*h + 0.5*a(i,2)*h**2
        end do

        !Velocidades con aceleraciones antiguas
        do i=1,9
            v(i,1) = v(i,1) + 0.5*a(i,1)*h
            v(i,2) = v(i,2) + 0.5*a(i,2)*h
        end do  
        
        ! Recalcular aceleraciones en nuevas posiciones
        do i=1,9
            a(i,1) = 0.0
            a(i,2) = 0.0
            do j=1,9
                if (j /= i) then
                    dist = sqrt((r(i,1)-r(j,1))**2 + (r(i,2)-r(j,2))**2)
                    a(i,1) =  a(i,1) - (m(j) * (r(i,1) - r(j,1)))/ dist**3
                    a(i,2) = a(i,2) - (m(j) * (r(i,2) - r(j,2)))/ dist**3      
                end if
            end do
        end do
        
        ! Actualizar velocidades
        do i=1,9
            v(i,1) = v(i,1) + 0.5*a(i,1)*h
            v(i,2) = v(i,2) + 0.5*a(i,2)*h
        end do
    
        ! Ajustar posiciones según el sistema de referencia
        if (heliocentric .eqv. .TRUE.) then
            r_ajustada = r
        else
            do i=1,9
                r_ajustada(i,1) = r(i,1) - r(4,1)
                r_ajustada(i,2) = r(i,2) - r(4,2)
            end do
        end if
        
        
        step = step + 1
        
        if (mod(step, 10) == 0) then
            write(1, *) ((r_ajustada(i,k), k=1,2), i=1,9)
        end if
        
        !Calcular periodos de los planetas
        do i = 2, 9 
            if (period_found(i) .eqv. .FALSE.) then 
                angle_curr = atan2(r(i,2), r(i,1))
                dtheta = angle_curr - prev_angle(i)

                ! Corregir el salto de fase de atan2 (+PI a -PI)
                if (dtheta > PI)  dtheta = dtheta - 2.0*PI
                if (dtheta < -PI) dtheta = dtheta + 2.0*PI

                total_angle(i) = total_angle(i) + dtheta
                prev_angle(i) = angle_curr

                ! Si el ángulo acumulado llega a 2*PI, se ha completado una órbita
                if (abs(total_angle(i)) >= 2.0*PI) then
                    period_years(i) = t / 6.27912
                    period_found(i) = .TRUE.
                end if
            end if
        end do

        !Calcular momento angular total del sistema
        do i = 1, 9
            moment_angular(i) = m(i) * (r(i,1)*v(i,2) - r(i,2)*v(i,1))
            moment_total = moment_total + moment_angular(i)
        end do

        if (mod(step, 5) == 0) then
            write (3,*) "Momento angular total: ", moment_total
        end if
        moment_total = 0.0

        !Calcular la energia total del sistema 
        do i = 1, 9
            kinetic = 0.5 * m(i) * (v(i,1)**2 + v(i,2)**2)
            potential = 0.0
            do j = i+1, 9
                if (j /= i) then
                    dist = sqrt((r(i,1)-r(j,1))**2 + (r(i,2)-r(j,2))**2)
                    potential = potential - (m(i)*m(j))/dist
                end if
            end do
            energy_total = energy_total + kinetic + potential 
        end do

        if (mod(step, 5) == 0) then
            write (4,*) "Energía total: ", energy_total
        end if
        energy_total = 0.0

        t=t+h
    end do

    do i = 2, 9
        write (*,*) "Planeta: ", planetas(i), "Periodo (dias): ", period_years(i)*365.25
        write (2,*) "Planeta: ", planetas(i), "Periodo (dias): ", period_years(i)*365.25
    end do

    close(1)
    close(2)
    close(3)
    close(4)

    read (*,*)
    
END PROGRAM sistema_solar