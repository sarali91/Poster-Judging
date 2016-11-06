module  JudgesHelper

    def get_rank(role)
        case role
        when 'superadmin'
             2
        when 'admin'
             1
        when 'judge'
        	 0
        else
        	-1
        end
    end
    def higher_rank?(role)
        if  get_rank(role) >= get_rank(current_user.role)
           return true
        else
           return false
        end
    end
    def sign_out_confirm()
        cf = nil
        if current_user.role == "judge"
            cf = "Do you agree to release you assignments to other judges?"
        end
        return cf
    end
    
end